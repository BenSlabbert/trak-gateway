package search

import (
	"github.com/BenSlabbert/go-sonic/sonic"
	log "github.com/sirupsen/logrus"
	"time"
)

// Sonic collections
const ProductCollection = "production-collection"
const CategoryCollection = "category-collection"
const BrandCollection = "brand-collection"

// Sonic buckets
const ProductBucket = "production-bucket"
const CategoryBucket = "category-bucket"
const BrandBucket = "brand-bucket"

type SonicSearch struct {
	env            Env
	ingestConnPool chan sonic.Ingestable
	searchConnPool chan sonic.Searchable
}

func CreateSonicSearch() (*SonicSearch, error) {
	ss := &SonicSearch{}
	ss.env = LoadEnv()

	ingestConnPool, e := createIngestPool(ss.env)
	if e != nil {
		return nil, e
	}

	searchConnPool, e := createSearchPool(ss.env)
	if e != nil {
		return nil, e
	}

	ss.ingestConnPool = ingestConnPool
	ss.searchConnPool = searchConnPool

	go ss.keepAlive()

	return ss, nil
}

func createSearchPool(env Env) (chan sonic.Searchable, error) {
	searchPoolSize := env.SonicSearchPoolSize
	searchConnPool := make(chan sonic.Searchable, searchPoolSize)
	for i := 0; i < searchPoolSize; i++ {
		sonicSearch, err := sonic.NewSearch(env.SonicHost, env.SonicPort, env.SonicPassword)
		if err != nil {
			return nil, err
		}
		searchConnPool <- sonicSearch
	}
	return searchConnPool, nil
}

func createIngestPool(env Env) (chan sonic.Ingestable, error) {
	ingestPoolSize := env.SonicIngesterPoolSize
	ingestConnPool := make(chan sonic.Ingestable, ingestPoolSize)
	for i := 0; i < ingestPoolSize; i++ {
		ingest, err := sonic.NewIngester(env.SonicHost, env.SonicPort, env.SonicPassword)
		if err != nil {
			return nil, err
		}
		ingestConnPool <- ingest
	}
	return ingestConnPool, nil
}

func (ss *SonicSearch) Quit() {
	ingestPoolSize := ss.env.SonicIngesterPoolSize
	// drain pool
	for i := 0; i < ingestPoolSize; i++ {
		i := <-ss.ingestConnPool
		log.Debug("quitting sonic ingester conn")
		e := i.Quit()
		if e != nil {
			log.Warnf("failed to quit ingester: %v", e)
		}
	}

	searchPoolSize := ss.env.SonicSearchPoolSize
	// drain pool
	for i := 0; i < searchPoolSize; i++ {
		i := <-ss.searchConnPool
		log.Debug("quitting sonic search conn")
		e := i.Quit()
		if e != nil {
			log.Warnf("failed to quit search: %v", e)
		}
	}
}

func (ss *SonicSearch) keepAlive() {
	ticker := time.NewTicker(10 * time.Second)

	for {
		select {
		case <-ticker.C:
			var ingestArr []sonic.Ingestable

			ingestPoolSize := ss.env.SonicIngesterPoolSize
			// drain pool
			for i := 0; i < ingestPoolSize; i++ {
				ingest := <-ss.ingestConnPool
				ingestArr = append(ingestArr, ingest)
			}

			// check connection
			for _, i := range ingestArr {
				err := i.Ping()
				if err != nil {
					log.Warnf("failed to ping sonic with ingester: %v", err)
					i, err = sonic.NewIngester(ss.env.SonicHost, ss.env.SonicPort, ss.env.SonicPassword)
					if err != nil {
						log.Errorf("failed to connect to sonic: %v", err)
						panic(err)
					}
				}

				// return instance to pool
				ss.ingestConnPool <- i
			}

			var searchArr []sonic.Searchable

			searchPoolSize := ss.env.SonicSearchPoolSize
			// drain pool
			for i := 0; i < searchPoolSize; i++ {
				search := <-ss.searchConnPool
				searchArr = append(searchArr, search)
			}

			// check connection
			for _, s := range searchArr {
				err := s.Ping()
				if err != nil {
					log.Warnf("failed to ping sonic with search: %v", err)
					s, err = sonic.NewSearch(ss.env.SonicHost, ss.env.SonicPort, ss.env.SonicPassword)
					if err != nil {
						log.Errorf("failed to connect to sonic: %v", err)
						panic(err)
					}
				}

				// return instance to pool
				ss.searchConnPool <- s
			}
		}
	}
}

func (ss *SonicSearch) Ingest(collection, bucket, object, text string) error {
	ingest := <-ss.ingestConnPool
	errs := ingest.Push(collection, bucket, object, text)
	ss.ingestConnPool <- ingest
	return errs
}

func (ss *SonicSearch) IngestBulk(collection, bucket string, records []sonic.IngestBulkRecord) []sonic.IngestBulkError {
	ingest := <-ss.ingestConnPool
	// only use 1 routine here
	errs := ingest.BulkPush(collection, bucket, 1, records)
	ss.ingestConnPool <- ingest
	return errs
}

func (ss *SonicSearch) Query(collection, bucket, terms string, limit, offset int) ([]string, error) {
	search := <-ss.searchConnPool
	results, err := search.Query(collection, bucket, terms, limit, offset)
	ss.searchConnPool <- search
	return results, err
}

func (ss *SonicSearch) Suggest(collection, bucket, word string, limit int) ([]string, error) {
	search := <-ss.searchConnPool
	results, err := search.Suggest(collection, bucket, word, limit)
	ss.searchConnPool <- search
	return results, err
}
