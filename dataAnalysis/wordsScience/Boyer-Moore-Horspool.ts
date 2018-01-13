const reverse = ([x, ...xs]) => xs.length > 0 ? [...reverse(xs), x] : [x]

const findWithDefault = (index: number, target: string, content: string): number => {
  for (let i = 0; i < content.length; i++) {
    if (target === content[i]) {
      index = i
      break
    }
  }
  return index 
}

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

  return _bmh(
    index + findWithDefault(reversePattern.length, content[index], reversePattern),
    reversePattern,
    content,
    pattern
  )
}

export function bmh (pattern: string, content: string): number {
  return _bmh(pattern.length - 1, reverse(pattern), content, pattern)
}