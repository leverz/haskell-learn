package main

import (
	"fmt"
)

func reverse(s string) string {
	runes := []rune(s)
	for i, j := 0, len(runes) - 1; i < j; i, j = i + 1, j - 1 {
		runes[i], runes[j] = runes[j], runes[i]
	}
	return string(runes)
}

func findWithDefault(index int, target string, content string) int {
	for i, length := 0, len(content); i < length; i++ {
		if target == string(content[i]) {
			index = i
			break
		}
	}
	return index
}

func _bmh(index int, revPattern string, content string, pattern string) int {
	if len(revPattern) == 0 {
		return index + 1
	}
	if index >= len(content) {
		return -1
	}
	if revPattern[0] == content[index] {
		return _bmh(index - 1, revPattern[1:], content, pattern)
	}
	var reversePattern = reverse(pattern)
	return _bmh(
		index + findWithDefault(len(reversePattern), string(content[index]), reversePattern),
		reversePattern,
		content,
		pattern)
}

func bmh(pattern string, content string) int {
	return _bmh(len(pattern) - 1, reverse(pattern), content, pattern)
}

func main() {
	fmt.Println(bmh("Wor", "Hello World"))
}
