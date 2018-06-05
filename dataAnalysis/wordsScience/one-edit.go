package main

import (
	"strings"
	"fmt"
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

func transposes(s string) []string {
	ts := make([]string, len(s) - 1)
	for i:=0; i<len(s) - 1; i++ {
		c := []byte(s)
		c[i], c[i+1] = c[i+1], c[i]
		ts[i] = string(c)
	}
	return ts
}

func replaces(s string) []string  {
	alphabetLen := len(Alphabet)
	length := len(s) * alphabetLen
	rs := make([]string, length)
	for i := range s {
		for j := range Alphabet {
			c := []byte(s)
			c[i] = Alphabet[j]
			rs[i+j] = string(c)
		}
	}
	return rs
}

func inserts (s string) []string {
	alphabetLen := len(Alphabet)
	length := (len(s) + 1) * alphabetLen
	is := make([]string, length)
	alphabet := []byte(Alphabet)
	for i := range s {
		for j := range alphabet {
			is[i+j] = string(s[:i] + string(alphabet[j]) + s[i:])
		}
	}
	return is
}


func edits1(word string) []string {
	lower := strings.ToLower(word)
	ds := deletes(lower)
	fmt.Println(len(ds))
	ts := transposes(lower)
	fmt.Println(len(ts))
	rs := replaces(lower)
	fmt.Println(len(rs))
	is := inserts(lower)
	fmt.Println(len(is))
	var words []string
	words = append(words, ds...)
	words = append(words, ts...)
	words = append(words, rs...)
	words = append(words, is...)
	return unique(words)
}

func main() {
	fmt.Println(edits1("hi"))
}
