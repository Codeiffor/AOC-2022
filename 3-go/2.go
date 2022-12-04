package main

import (
	"errors"
	"fmt"
	"os"
	"strings"
)

func handleError(err error) {
	if err != nil {
		panic(err)
	}
}

func getCommonCharacter(str []string) rune {
	visited := map[rune]struct{}{}
	visited2 := map[rune]struct{}{}
	for _, i := range str[0] {
		visited[i] = struct{}{}
	}
	for _, i := range str[1] {
		visited2[i] = struct{}{}
	}
	for _, i := range str[2] {
		if _, ok := visited[i]; ok {
			if _, ok := visited2[i]; ok {
				return i
			}
		}
	}
	panic(errors.New("no common"))
}

func main() {
	data, err := os.ReadFile("./input.txt")
	handleError(err)
	rucksacks := strings.Split(string(data), "\n")
	sum := 0
	for i := 0; i < len(rucksacks); i += 3 {
		c := getCommonCharacter(rucksacks[i : i+3])
		priority := int(c - '`')
		if priority < 0 {
			priority += 58
		}
		sum += priority
	}
	fmt.Println(sum)
}
