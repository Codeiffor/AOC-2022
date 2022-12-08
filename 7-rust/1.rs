use std::io::{self, BufRead };
use std::collections::{HashSet, HashMap};

fn main() {
  let input = io::stdin().lock().lines();
  
  let mut dirs = Vec::new();
  let mut parent: HashMap<String, String> = HashMap::new();
  let mut size = HashMap::new();

  let mut level = 0;
  let mut cdir = "/".to_string(); 
  
  for _line in input {
    let line = _line.unwrap();
    let args: Vec<&str> = line.split_whitespace().collect();

    if args[0] == "$" {
      if args[1] == "cd" {
        if args[2] == "/" {
          level = 0;
          cdir = args[2].to_string();
        } else if args[2] == ".." {
          level -= 1;
          cdir = parent[&cdir].to_string()
        } else {
          level += 1;
          let tmp = cdir.to_string() + &args[2].to_string() + "/";
          parent.insert(tmp.to_string(), cdir.to_string());
          cdir = tmp.to_string();
          if dirs.len() < level {
            dirs.push(HashSet::new());
          }
          dirs[level - 1].insert(cdir.to_string());
        }
      }
      if args[1] == "ls" {
        size.insert(cdir.to_string(), 0);
      }
    } else if args[0] != "dir" {
      size.insert(cdir.to_string(), size[&cdir] + args[0].parse::<i64>().unwrap());
    }
  }
  
  for ldir in dirs.iter().rev() {
    for dir in ldir {
      size.insert(parent[dir].to_string(), size[&parent[dir]] + size[dir]);
    }
  }
  
  let mut sum = 0i64;
  for (_, s) in size {
    if s <= 100_000 {
      sum += s;
    }
  }
  println!("sum={}", sum);
}