import { BaseConfig } from "https://deno.land/x/ddu_vim@v3.6.0/types.ts";
import { ConfigArguments } from "https://deno.land/x/ddu_vim@v3.6.0/base/config.ts";
import { Denops, fn } from "https://deno.land/x/ddu_vim@v3.6.0/deps.ts";
import {
  Params as FfParams,
  Ui as FfUi,
} from "https://deno.land/x/ddu_ui_ff@v1.1.0/ff.ts";

export class Config extends BaseConfig {
  override config({ contextBuilder }: ConfigArguments): Promise<void> {
    const ffParamsDefault = new FfUi().params();
    const ffUiParams: FfParams = {
      ...ffParamsDefault,
      autoAction: {
        name: "preview",
      },
      filterSplitDirection: "floating",
      floatingBorder: "single",
      highlights: {
        filterText: "Statement",
        floating: "Normal",
        floatingBorder: "Special",
      },
      onPreview: async (args: {
        denops: Denops;
        previewWinId: number;
      }) => {
        await fn.win_execute(args.denops, args.previewWinId, "normal! zt");
      },
      previewFloating: true,
      previewFloatingBorder: "single",
      previewSplit: "no",
      startFilter: true,
      winWidth: 100,
    };

    contextBuilder.patchGlobal({
      ui: "ff",
      profile: false,
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
          converters: ["converter_hl_dir"],
        },
      },
      sourceParams: {},
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
