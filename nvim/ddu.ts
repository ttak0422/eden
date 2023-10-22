import { BaseConfig } from "https://deno.land/x/ddu_vim@v3.6.0/types.ts";
import { ConfigArguments } from "https://deno.land/x/ddu_vim@v3.6.0/base/config.ts";
import { Denops, fn } from "https://deno.land/x/ddu_vim@v3.6.0/deps.ts";
import {
  Params as FfParams,
  Ui as FfUi,
} from "https://deno.land/x/ddu_ui_ff@v1.1.0/ff.ts";

export class Config extends BaseConfig {
  override config(
    { contextBuilder, setAlias }: ConfigArguments,
  ): Promise<void> {
    setAlias("source", "file_fd", "file_external");

    const ffParamsDefault = new FfUi().params();
    const ffUiParams: FfParams = {
      ...ffParamsDefault,
      ignoreEmpty: true,
      startAutoAction: true,
      autoAction: {
        name: "preview",
        delay: 250, // same as telescope.nvim
      },
      autoResize: false,
      displaySourceName: "no",
      filterSplitDirection: "floating",
      filterFloatingPosition: "top",
      floatingBorder: "single",
      highlights: {
        filterText: "Statement",
        floating: "Normal",
        floatingBorder: "Special",
        selected: "CursorLine",
      },
      onPreview: async (args: {
        denops: Denops;
        previewWinId: number;
      }) => {
        await fn.win_execute(args.denops, args.previewWinId, "normal! zt");
      },
      winRow: "&lines / 3 * 2",
      winCol: 1,
      winHeight: "&lines / 3 - 2",
      winWidth: "&columns - 2",
      previewSplit: "no",
      startFilter: true,
      prompt: " ",
      split: "floating",
    };

    contextBuilder.patchGlobal({
      ui: "ff",
      profile: false,
      sources: [
        "file",
        "file_rec",
        "file_external",
        "ghq",
      ],
      uiOptions: {},
      uiParams: {
        ff: ffUiParams,
      },
      sourceOptions: {
        _: {
          ignoreCase: true,
          matchers: ["matcher_substring"],
          smartCase: true,
        },
        file: {
          matchers: [
            "matcher_substring",
            "matcher_hidden",
          ],
          sorters: ["sorter_alpha"],
          converters: ["converter_hl_dir", "converter_devicon"],
          smartCase: true,
        },
        rg: {
          matchers: [
            "converter_display_word",
            "matcher_substring",
            "matcher_files",
          ],
          sorters: ["sorter_alpha"],
        },
        ghq: {
          defaultAction: "cd",
        },
      },
      sourceParams: {
        file: {
          new: false,
        },
        file_fd: {
          cmd: ["fd", ".", "-H", "-t", "f"],
        },
        rg: {
          args: ["--json"],
        },
      },
      filterOptions: {},
      filterParams: {
        matcher_substring: {
          highlightMatched: "Search",
        },
        converter_hl_dir: {
          hlGroup: ["Directory", "Keyword"],
        },
      },
      kindOptions: {
        file: {
          defaultAction: "open",
        },
      },
      kindParams: {},
      actionOptions: {},
      actionParams: {},
    });
    return Promise.resolve();
  }
}
