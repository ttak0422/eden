import type { Snippet } from "./deps.ts";

const nonEmptyList: Snippet = {
  name: "NonEmptyList",
  params: [],
  render: (_, { postCursor }) =>
    `type NonEmptyList<T> = [T, ...T[]]${postCursor}`,
};

const nonEmptyGuard: Snippet = {
  name: "NonEmpty Guard",
  params: [],
  render: (_, { postCursor }) => `
function nonEmpty<T>(list: T[]): list is NonEmptyList<T> {
  return list.length > 0;
}${postCursor}
  `,
};

const neverMatch: Snippet = {
  name: "Never Match",
  params: [
    { name: "value",
      type: "single_line",
    }
  ],
  render: ({ value }, { postCursor }) => `
const never: never = ${value?.text ?? ""};
throw new Error(never);${postCursor}
  `,
}

export default {
  nonEmptyList,
  nonEmptyGuard,
  neverMatch,
};
