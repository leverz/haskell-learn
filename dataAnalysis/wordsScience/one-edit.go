package main

import (
	"strings"
)

const Alphabet = "abcdefghijklmnopqrstuvwxyz"

func Map(vs []string, f func(string) string) []string {
	vsm := make([]string, len(vs))
	for i, v := range vs {
		vsm[i] = f(v)
	}
	return vsm
}

func head(vs []string) string {
	return vs[0]
}

func group(vs []string) map[string]int {
	vsg := make(map[string]int)
	for _, v := range vs {
		_, had := vsg[v]
		if had {
			vsg[v]++
		} else {
			vsg[v] = 1
		}
	}
	return vsg
}

func keys(m map[string]int) []string {
	keys := make([]string, len(m))
	i := 0
	for k := range m {
		keys[i] = k
		i++
	}
	return keys
}

func unique(s []string) []string {
	return keys(group(s))
}

func deletes(s string) []string  {
	ds := make([]string, len(s))
	for i := range s {
		ds[i] = s[0:i] + s[i+1:]
	}
	return ds
}


func edits1(word string) []string {
	_word := strings.ToLower(word)
}
