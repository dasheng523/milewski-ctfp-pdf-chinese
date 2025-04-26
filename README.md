![GitHub stars][github stars]
[![GitHub Workflow Status][github workflow status]][github actions link]
[![下载][download badge]][github latest release]
[![许可证][license badge]][github latest release]

# 给程序员的范畴论

由 [Bartosz Milewski][bartosz github] 撰写的《**给**程序员的**范**畴**论**》(Category Theory For Programmers) 的一个_非官方_ PDF 版本，从他的[系列博文][blogpost series]转换而来（_已获许可！_）。

![给程序员的范畴论][ctfp image]

## 购买本书

-   **[标准版全彩精装印刷版][buy regular edition on blurb]**
    -   出版日期：2019 年 8 月 12 日。
    -   基于发布标签 [v1.3.0][v1.3.0 github release link]。关于印刷后的更改和修复，请参阅 [errata-1.3.0](errata-1.3.0.md)。
-   **[Scala 版平装版][buy scala edition on blurb]**
    -   出版日期：2019 年 8 月 12 日。
    -   基于发布标签 [v1.3.0][v1.3.0 github release link]。关于印刷后的更改和修复，请参阅 [errata-scala](errata-scala.md)。

## 构建本书

构建工作流需要 [Nix][nix website]。在[安装 Nix][nix download website] 之后，你需要启用即将推出的 "flake" 功能，该功能目前必须[手动启用][nixos wiki flake]。这是为了暴露隐藏在功能标志后面的新 Nix 命令和 flakes 支持。

之后，在项目的根目录中输入 `nix flake show` 来查看本书所有可用的版本。然后输入 `nix build .#<edition>` 来构建你想要的版本（Scala、OCaml、Reason 及其印刷版本）。例如，要构建 Scala 版本，你需要输入 `nix build .#ctfp-scala`。对于 Haskell（原始版本），只需输入 `nix build .#ctfp`。

编译成功后，PDF 文件将放置在 `result` 目录中。

命令 `nix develop` 将提供一个包含所有必需依赖项的 Shell 环境，以便使用提供的 `Makefile` 手动构建本书。要构建 `ctfp-scala` 版本，只需运行 `make ctfp-scala`。

## 贡献

欢迎贡献者通过发送 Pull Request 为本书做出贡献。在审查之后，更改将合并到主分支 (main branch) 中，并将包含在下一个版本 (release) 中。

**来自 [Bartosz][bartosz github] 的说明**：我非常感谢你们所有的贡献。你们让这本书变得比我想象的要好得多。谢谢你们！

在 [Github 上查找贡献者列表][contributors]。

## 致谢

PDF LaTeX 源代码及其创建工具基于 [Andres Raba][andres raba github] 的工作。本书内容经许可取自 [Bartosz Milewski][bartosz github] 的系列博文，并改编为 LaTeX 格式。

Bartosz 的原始博文致谢已整合在本书末尾的 _致谢_ 页面中。

## 许可证

PDF 书籍、`.tex` 文件以及 `src/fig` 和 `src/content` 目录中的相关图像和图表采用 [知识共享署名-相同方式共享 4.0 国际许可协议][license cc by sa] 授权。

脚本文件 `scraper.py` 及其他文件采用 [GNU 通用公共许可证版本 3][license gnu gpl] 授权。

[download badge]:
  https://img.shields.io/badge/Download-latest-green.svg?style=flat-square
[github actions link]: https://github.com/hmemcpy/milewski-ctfp-pdf/actions
[github stars]:
  https://img.shields.io/github/stars/hmemcpy/milewski-ctfp-pdf.svg?style=flat-square
[github workflow status]:
  https://img.shields.io/github/actions/workflow/status/hmemcpy/milewski-ctfp-pdf/nix-flake-check.yaml?branch=master&style=flat-square
[github latest release]:
  https://github.com/hmemcpy/milewski-ctfp-pdf/releases/latest
[license badge]:
  https://img.shields.io/badge/License-CC_By_SA-green.svg?style=flat-square
[ctfp image]:
  https://user-images.githubusercontent.com/601206/47271389-8eea0900-d581-11e8-8e81-5b932e336336.png
[bartosz github]: https://github.com/BartoszMilewski
[nixos wiki flake]: https://wiki.nixos.org/wiki/Flakes
[andres raba github]: https://github.com/sarabander
[contributors]: https://github.com/hmemcpy/milewski-ctfp-pdf/graphs/contributors
[license cc by sa]: https://spdx.org/licenses/CC-BY-SA-4.0.html
[license gnu gpl]: https://spdx.org/licenses/GPL-3.0.html
[blogpost series]:
  https://bartoszmilewski.com/2014/10/28/category-theory-for-programmers-the-preface/
[buy regular edition on blurb]:
  https://www.blurb.com/b/9621951-category-theory-for-programmers-new-edition-hardco
[buy scala edition on blurb]:
  https://www.blurb.com/b/9603882-category-theory-for-programmers-scala-edition-pape
[v1.3.0 github release link]:
  https://github.com/hmemcpy/milewski-ctfp-pdf/releases/tag/v1.3.0
[nix website]: https://nixos.org/nix/
[nix download website]: https://nixos.org/download.html