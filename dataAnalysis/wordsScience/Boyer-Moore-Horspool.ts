const reverse = ([x, ...xs]) => xs.length > 0 ? [...reverse(xs), x] : [x]

const _bmh = (index: number, [p, ...revPat], content: string, pattern: string): number => {
  if (!p) {
    return index + 1
  }
  if (index >= content.length) {
    return -1
  }
  if (p === content[index]) {
    return _bmh(index - 1, revPat, content, pattern)
  }
  const reversePattern = reverse(pattern)
  const addIndex = reversePattern.reduce(
    (addIndex, cur, index) => content[index] === cur && (addIndex = index), -1)
  return _bmh(index + (addIndex > 0 ? addIndex : pattern.length), reversePattern, content, pattern)
}

export function bmh (pattern: string, content: string): number {
  return _bmh(pattern.length - 1, reverse(pattern), content, pattern)
}