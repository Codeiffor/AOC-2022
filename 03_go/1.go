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

func getCommonCharacter(str1 string, str2 string) rune {
	visited := map[rune]struct{}{}
	for _, i := range str1 {
		visited[i] = struct{}{}
	}
	for _, i := range str2 {
		if _, ok := visited[i]; ok {
			return i
		}
	}
	panic(errors.New("no common"))
}

func main() {
	data, err := os.ReadFile("./input.txt")
	handleError(err)
	rucksacks := strings.Split(string(data), "\n")
	sum := 0
	for _, rucksack := range rucksacks {
		c := getCommonCharacter(rucksack[:len(rucksack)/2], rucksack[len(rucksack)/2:])
		priority := int(c - '`')
		if priority < 0 {
			priority += 58
		}
		sum += priority
	}
	fmt.Println(sum)
}
