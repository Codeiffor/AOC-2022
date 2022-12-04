const fs = require("fs")
const data = fs.readFileSync("./input.txt").toString().split('\n').map(d => d.split(" "))
const res = data.reduce((acc, red) => {
  acc += red[1].charCodeAt() - 87
  if (red[1].charCodeAt() - red[0].charCodeAt() == 23) acc += 3
  else if (
    (red[0] == 'A' && red[1] == 'Y') ||
    (red[0] == 'B' && red[1] == 'Z') ||
    (red[0] == 'C' && red[1] == 'X')
  ) acc += 6
  return acc
}, 0)
console.log(res)