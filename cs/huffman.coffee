frequencies = [
  { symbol: "E", f: 12.02 }
  { symbol: "T", f:  9.10 }
  { symbol: "A", f:  8.12 }
  { symbol: "O", f:  7.68 }
  { symbol: "I", f:  7.31 }
  { symbol: "N", f:  6.95 }
  { symbol: "S", f:  6.28 }
  { symbol: "R", f:  6.02 }
  { symbol: "H", f:  5.92 }
  { symbol: "D", f:  4.32 }
  { symbol: "L", f:  3.98 }
  { symbol: "U", f:  2.88 }
  { symbol: "C", f:  2.71 }
  { symbol: "M", f:  2.61 }
  { symbol: "F", f:  2.30 }
  { symbol: "Y", f:  2.11 }
  { symbol: "W", f:  2.09 }
  { symbol: "G", f:  2.03 }
  { symbol: "P", f:  1.82 }
  { symbol: "B", f:  1.49 }
  { symbol: "V", f:  1.11 }
  { symbol: "K", f:  0.69 }
  { symbol: "X", f:  0.17 }
  { symbol: "Q", f:  0.11 }
  { symbol: "J", f:  0.10 }
  { symbol: "Z", f:  0.07 }
]

queue = frequencies[..]

while queue.length > 1
  # sort the queue
  queue.sort (a, b) ->
    b.f - a.f

  # remove the last two entries
  left = queue[-1..][0]
  right = queue[-2...-1][0]
  queue = queue[0...-2]

  # Add the combined node
  queue.push { left: left, right: right, f: left.f + right.f }

# generate the code dictionary

child = (node, code, d) ->
  if node.symbol?
    d.push { symbol: node.symbol, code: code}
  else
    child node.left, code+"0", d
    child node.right, code+"1", d

dictionary = []
child queue[0], "", dictionary

# output the dictionary
dictionary.sort (a, b) ->
  return if a.symbol > b.symbol then 1 else -1

console.log JSON.stringify(dictionary)
