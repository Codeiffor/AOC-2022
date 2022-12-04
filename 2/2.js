const fs = require("fs")
const data = fs.readFileSync("./input.txt").toString().split('\n').map(d => d.split(" "))
const res = data.reduce((acc, red) => {
  const x = red[1].charCodeAt() - 88 
  acc += x * 3 + (red[0].charCodeAt() - 63 + x) % 3 + 1
  return acc
}, 0)
console.log(res)