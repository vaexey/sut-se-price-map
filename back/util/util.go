package util

import "time"



const DATE_PATTERN = time.RFC3339

func Paginate[T any](arr []T, skip uint, limit uint) []T {
	arrLen := uint(len(arr))
	if skip > arrLen {
		return make([]T, 0)
	}
	if skip + limit > arrLen {
		return arr[skip:arrLen]
	}
	return arr[skip:skip+limit]
}

func Filter[T any](ss []T, test func(T) bool) (ret []T) {
	for _, s := range ss {
		if test(s) {
			ret = append(ret, s)
		}
	}
	return
}

func TimeNow() string {
	return time.Now().Format(DATE_PATTERN)
}
