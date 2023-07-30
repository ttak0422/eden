import type { Snippet } from "./deps.ts";

const completedFuture: Snippet = {
  name: "completedFuture",
  params: [],
  render: (_, { postCursor }) =>
    `CompletableFuture.completedFuture(${postCursor})`,
};

export default {
  completedFuture,
};
