;;; markdown-mode.el --- Emacs Major mode for Markdown-formatted text files

;; Copyright (C) 2007-2013 Jason R. Blevins <jrblevin@sdf.org>
;; Copyright (C) 2007, 2009 Edward O'Connor <ted@oconnor.cx>
;; Copyright (C) 2007 Conal Elliott <conal@conal.net>
;; Copyright (C) 2008 Greg Bognar <greg_bognar@hms.harvard.edu>
;; Copyright (C) 2008 Dmitry Dzhus <mail@sphinx.net.ru>
;; Copyright (C) 2008 Bryan Kyle <bryan.kyle@gmail.com>
;; Copyright (C) 2008 Ben Voui <intrigeri@boum.org>
;; Copyright (C) 2009 Ankit Solanki <ankit.solanki@gmail.com>
;; Copyright (C) 2009 Hilko Bengen <bengen@debian.org>
;; Copyright (C) 2009 Peter Williams <pezra@barelyenough.org>
;; Copyright (C) 2010 George Ogata <george.ogata@gmail.com>
;; Copyright (C) 2011 Eric Merritt <ericbmerritt@gmail.com>
;; Copyright (C) 2011 Philippe Ivaldi <pivaldi@sfr.fr>
;; Copyright (C) 2011 Jeremiah Dodds <jeremiah.dodds@gmail.com>
;; Copyright (C) 2011 Christopher J. Madsen <cjm@cjmweb.net>
;; Copyright (C) 2011 Shigeru Fukaya <shigeru.fukaya@gmail.com>
;; Copyright (C) 2011 Joost Kremers <joostkremers@fastmail.fm>
;; Copyright (C) 2011-2012 Donald Ephraim Curtis <dcurtis@milkbox.net>
;; Copyright (C) 2012 Akinori Musha <knu@idaemons.org>
;; Copyright (C) 2012 Zhenlei Jia <zhenlei.jia@gmail.com>
;; Copyright (C) 2012 Peter Jones <pjones@pmade.com>
;; Copyright (C) 2013 Matus Goljer <dota.keys@gmail.com>

;; Author: Jason R. Blevins <jrblevin@sdf.org>
;; Maintainer: Jason R. Blevins <jrblevin@sdf.org>
;; Created: May 24, 2007
;; Version: 20131210.700
;; X-Original-Version: 2.0
;; Keywords: Markdown, GitHub Flavored Markdown, itex
;; URL: http://jblevins.org/projects/markdown-mode/

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; markdown-mode is a major mode for editing [Markdown][]-formatted
;; text files in GNU Emacs.  markdown-mode is free software, licensed
;; under the GNU GPL.
;;
;;  [Markdown]: http://daringfireball.net/projects/markdown/
;;
;; The latest stable version is markdown-mode 2.0, released on March 24, 2013:
;;
;;    * [markdown-mode.el][]
;;    * [Screenshot][][^theme]
;;    * [Release notes][]
;;
;;  [markdown-mode.el]: http://jblevins.org/projects/markdown-mode/markdown-mode.el
;;  [screenshot]: http://jblevins.org/projects/markdown-mode/screenshots/20130131-002.png
;;  [release notes]: http://jblevins.org/projects/markdown-mode/rev-2-0
;;
;; [^theme]: The theme used in the screenshot is
;;   [color-theme-twilight](https://github.com/crafterm/twilight-emacs).
;;
;; markdown-mode is also available in several package managers, including:
;;
;;    * Debian and Ubuntu Linux: [emacs-goodies-el][]
;;    * RedHat and Fedora Linux: [emacs-goodies][]
;;    * NetBSD: [textproc/markdown-mode][]
;;    * Arch Linux (AUR): [emacs-markdown-mode-git][]
;;    * MacPorts: [markdown-mode.el][macports-package] ([pending][macports-ticket])
;;    * FreeBSD: [textproc/markdown-mode.el][freebsd-port]
;;
;;  [emacs-goodies-el]: http://packages.debian.org/emacs-goodies-el
;;  [emacs-goodies]: https://admin.fedoraproject.org/pkgdb/acls/name/emacs-goodies
;;  [textproc/markdown-mode]: http://pkgsrc.se/textproc/markdown-mode
;;  [emacs-markdown-mode-git]: http://aur.archlinux.org/packages.php?ID=30389
;;  [macports-package]: https://trac.macports.org/browser/trunk/dports/editors/markdown-mode.el/Portfile
;;  [macports-ticket]: http://trac.macports.org/ticket/35716
;;  [freebsd-port]: http://svnweb.freebsd.org/ports/head/textproc/markdown-mode.el
;;
;; The latest development version can be downloaded directly
;; ([markdown-mode.el][devel.el]) or it can be obtained from the
;; (browsable and clonable) Git repository at
;; <http://jblevins.org/git/markdown-mode.git>.  The entire repository,
;; including the full project history, can be cloned via the Git protocol
;; by running
;;
;;     git clone git://jblevins.org/git/markdown-mode.git
;;
;;  [devel.el]: http://jblevins.org/git/markdown-mode.git/plain/markdown-mode.el

;;; Installation:

;; Make sure to place `markdown-mode.el` somewhere in the load-path and add
;; the following lines to your `.emacs` file to associate markdown-mode
;; with `.text`, `.markdown`, and `.md` files:
;;
;;     (autoload 'markdown-mode "markdown-mode"
;;        "Major mode for editing Markdown files" t)
;;     (add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
;;     (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
;;     (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
;;
;; There is no official Markdown file extension, nor is there even a
;; _de facto_ standard, so you can easily add, change, or remove any
;; of the file extensions above as needed.

;;; Usage:

;; Keybindings are grouped by prefixes based on their function.  For
;; example, the commands for inserting links are grouped under `C-c
;; C-a`, where the `C-a` is a mnemonic for the HTML `<a>` tag.  In
;; other cases, the connection to HTML is not direct.  For example,
;; commands dealing with headings begin with `C-c C-t` (mnemonic:
;; titling).  The primary commands in each group will are described
;; below.  You can obtain a list of all keybindings by pressing `C-c
;; C-h`.  Movement and shifting commands tend to be associated with
;; paired delimiters such as `M-{` and `M-}` or `C-c <` and `C-c >`.
;; Outline navigation keybindings the same as in `org-mode'.  Finally,
;; commands for running Markdown or doing maintenance on an open file
;; are grouped under the `C-c C-c` prefix.  The most commonly used
;; commands are described below.  You can obtain a list of all
;; keybindings by pressing `C-c C-h`.
;;
;;   * Hyperlinks: `C-c C-a`
;;
;;     In this group, `C-c C-a l` inserts an inline link of the form
;;     `[text](url)`.  The link text is determined as follows.  First,
;;     if there is an active region (i.e., when transient mark mode is
;;     on and the mark is active), use it as the link text.  Second,
;;     if the point is at a word, use that word as the link text.  In
;;     these two cases, the original text will be replaced with the
;;     link and point will be left at the position for inserting a
;;     URL.  Otherwise, insert empty link markup and place the point
;;     for inserting the link text.
;;
;;     `C-c C-a L` inserts a reference link of the form `[text][label]`
;;     and, optionally, a corresponding reference label definition.
;;     The link text is determined in the same way as with an inline
;;     link (using the region, when active, or the word at the point),
;;     but instead of inserting empty markup as a last resort, the
;;     link text will be read from the minibuffer.  The reference
;;     label will be read from the minibuffer in both cases, with
;;     completion from the set of currently defined references.  To
;;     create an implicit reference link, press `RET` to accept the
;;     default, an empty label.  If the entered referenced label is
;;     not defined, additionally prompt for the URL and (optional)
;;     title.  If a URL is provided, a reference definition will be
;;     inserted in accordance with `markdown-reference-location'.
;;     If a title is given, it will be added to the end of the
;;     reference definition and will be used to populate the title
;;     attribute when converted to XHTML.
;;
;;     `C-c C-a u` inserts a bare url, delimited by angle brackets.  When
;;     there is an active region, the text in the region is used as the
;;     URL.  If the point is at a URL, that url is used.  Otherwise,
;;     insert angle brackets and position the point in between them
;;     for inserting the URL.
;;
;;     `C-c C-a f` inserts a footnote marker at the point, inserts a
;;     footnote definition below, and positions the point for
;;     inserting the footnote text.  Note that footnotes are an
;;     extension to Markdown and are not supported by all processors.
;;
;;     `C-c C-a w` behaves much like the inline link insertion command
;;     and inserts a wiki link of the form `[[WikiLink]]`.  If there
;;     is an active region, use the region as the link text.  If the
;;     point is at a word, use the word as the link text.  If there is
;;     no active region and the point is not at word, simply insert
;;     link markup.  Note that wiki links are an extension to Markdown
;;     and are not supported by all processors.
;;
;;   * Images: `C-c C-i`
;;
;;     `C-c C-i i` inserts markup for an inline image, using the
;;     active region or the word at point, if any, as the alt text.
;;     `C-c C-i I` behaves similarly and inserts a reference-style
;;     image.
;;
;;   * Styles: `C-c C-s`
;;
;;     `C-c C-s e` inserts markup to make a region or word italic (`e`
;;     for `<em>` or emphasis).  If there is an active region, make
;;     the region italic.  If the point is at a non-italic word, make
;;     the word italic.  If the point is at an italic word or phrase,
;;     remove the italic markup.  Otherwise, simply insert italic
;;     delimiters and place the cursor in between them.  Similarly,
;;     use `C-c C-s s` for bold (`<strong>`) and `C-c C-s c` for
;;     inline code (`<code>`).
;;
;;     `C-c C-s b` inserts a blockquote using the active region, if any,
;;     or starts a new blockquote.  `C-c C-s C-b` is a variation which
;;     always operates on the region, regardless of whether it is
;;     active or not.  The appropriate amount of indentation, if any,
;;     is calculated automatically given the surrounding context, but
;;     may be adjusted later using the region indentation commands.
;;
;;     `C-c C-s p` behaves similarly for inserting preformatted code
;;     blocks, with `C-c C-s C-p` being the region-only counterpart.
;;
;;   * Headings: `C-c C-t`
;;
;;     All heading insertion commands use the text in the active
;;     region, if any, as the heading text.  Otherwise, if the current
;;     line is not blank, they use the text on the current line.
;;     Finally, the setext commands will prompt for heading text if
;;     there is no active region and the current line is blank.
;;     
;;     `C-c C-t h` inserts a heading with automatically chosen type and
;;     level (both determined by the previous heading).  `C-c C-t H`
;;     behaves similarly, but uses setext (underlined) headings when
;;     possible, still calculating the level automatically.
;;     In cases where the automatically-determined level is not what
;;     you intended, the level can be quickly promoted or demoted
;;     (as described below).  Alternatively, a `C-u` prefix can be
;;     given to insert a heading promoted by one level or a `C-u C-u`
;;     prefix can be given to insert a heading demoted by one level.
;;
;;     To insert a heading of a specific level and type, use `C-c C-t 1`
;;     through `C-c C-t 6` for atx (hash mark) headings and `C-c C-t !` or
;;     `C-c C-t @` for setext headings of level one or two, respectively.
;;     Note that `!` is `S-1` and `@` is `S-2`.
;;
;;     If the point is at a heading, these commands will replace the
;;     existing markup in order to update the level and/or type of the
;;     heading.  To remove the markup of the heading at the point,
;;     press `C-c C-k` to kill the heading and press `C-y` to yank the
;;     heading text back into the buffer.
;;
;;   * Horizontal Rules: `C-c -`
;;
;;     `C-c -` inserts a horizontal rule.  By default, insert the
;;     first string in the list `markdown-hr-strings' (the most
;;     prominent rule).  With a `C-u` prefix, insert the last string.
;;     With a numeric prefix `N`, insert the string in position `N`
;;     (counting from 1).
;;
;;   * Markdown and Maintenance Commands: `C-c C-c`
;;
;;     *Compile:* `C-c C-c m` will run Markdown on the current buffer
;;     and show the output in another buffer.  *Preview*: `C-c C-c p`
;;     runs Markdown on the current buffer and previews, stores the
;;     output in a temporary file, and displays the file in a browser.
;;     *Export:* `C-c C-c e` will run Markdown on the current buffer
;;     and save the result in the file `basename.html`, where
;;     `basename` is the name of the Markdown file with the extension
;;     removed.  *Export and View:* press `C-c C-c v` to export the
;;     file and view it in a browser.  **For both export commands, the
;;     output file will be overwritten without notice.**
;;     *Open:* `C-c C-c o` will open the Markdown source file directly
;;     using `markdown-open-command'.
;;
;;     To summarize:
;;
;;       - `C-c C-c m`: `markdown-command' > `*markdown-output*` buffer.
;;       - `C-c C-c p`: `markdown-command' > temporary file > browser.
;;       - `C-c C-c e`: `markdown-command' > `basename.html`.
;;       - `C-c C-c v`: `markdown-command' > `basename.html` > browser.
;;       - `C-c C-c w`: `markdown-command' > kill ring.
;;       - `C-c C-c o`: `markdown-open-command'.
;;
;;     `C-c C-c c` will check for undefined references.  If there are
;;     any, a small buffer will open with a list of undefined
;;     references and the line numbers on which they appear.  In Emacs
;;     22 and greater, selecting a reference from this list and
;;     pressing `RET` will insert an empty reference definition at the
;;     end of the buffer.  Similarly, selecting the line number will
;;     jump to the corresponding line.
;;
;;     `C-c C-c n` renumbers any ordered lists in the buffer that are
;;     out of sequence.
;;
;;     `C-c C-c ]` completes all headings and normalizes all horizontal
;;     rules in the buffer.
;;
;;   * Following Links: `C-c C-o`
;;
;;     Press `C-c C-o` when the point is on an inline or reference
;;     link to open the URL in a browser.  When the point is at a
;;     wiki link, open it in another buffer (in the current window,
;;     or in the other window with the `C-u` prefix).  Use `M-p` and
;;     `M-n` to quickly jump to the previous or next link of any type.
;;
;;   * Jumping: `C-c C-j`
;;
;;     Use `C-c C-j` to jump from the object at point to its counterpart
;;     elsewhere in the text, when possible.  Jumps between reference
;;     links and definitions; between footnote markers and footnote
;;     text.  If more than one link uses the same reference name, a
;;     new buffer will be created containing clickable buttons for jumping
;;     to each link.  You may press `TAB` or `S-TAB` to jump between
;;     buttons in this window.
;;
;;   * Promotion and Demotion: `C-c C--` and `C-c C-=`
;;
;;     Headings, horizontal rules, and list items can be promoted and
;;     demoted, as well as bold and italic text.  For headings,
;;     "promotion" means *decreasing* the level (i.e., moving from
;;     `<h2>` to `<h1>`) while "demotion" means *increasing* the
;;     level.  For horizontal rules, promotion and demotion means
;;     moving backward or forward through the list of rule strings in
;;     `markdown-hr-strings'.  For bold and italic text, promotion and
;;     demotion means changing the markup from underscores to asterisks.
;;     Press `C-c C--` or `M-LEFT` to promote the element at the point
;;     if possible.
;;
;;     To remember these commands, note that `-` is for decreasing the
;;     level (promoting), and `=` (on the same key as `+`) is for
;;     increasing the level (demoting).  Similarly, the left and right
;;     arrow keys indicate the direction that the atx heading markup
;;     is moving in when promoting or demoting.
;;
;;   * Completion: `C-c C-]`
;;
;;     Complete markup is in normalized form, which means, for
;;     example, that the underline portion of a setext header is the
;;     same length as the heading text, or that the number of leading
;;     and trailing hash marks of an atx header are equal and that
;;     there is no extra whitespace in the header text.  `C-c C-]`
;;     completes the markup at the point, if it is determined to be
;;     incomplete.
;;
;;   * Editing Lists: `M-RET`, `M-UP`, `M-DOWN`, `M-LEFT`, and `M-RIGHT`
;;
;;     New list items can be inserted with `M-RET`.  This command
;;     determines the appropriate marker (one of the possible
;;     unordered list markers or the next number in sequence for an
;;     ordered list) and indentation level by examining nearby list
;;     items.  If there is no list before or after the point, start a
;;     new list.  Prefix this command by `C-u` to decrease the
;;     indentation by one level.  Prefix this command by `C-u C-u` to
;;     increase the indentation by one level.
;;
;;     Existing list items can be moved up or down with `M-UP` or
;;     `M-DOWN` and indented or exdented with `M-RIGHT` or `M-LEFT`.
;;
;;   * Shifting the Region: `C-c <` and `C-c >`
;;
;;     Text in the region can be indented or exdented as a group using
;;     `C-c >` to indent to the next indentation point (calculated in
;;     the current context), and `C-c <` to exdent to the previous
;;     indentation point.  These keybindings are the same as those for
;;     similar commands in `python-mode'.
;;
;;   * Killing Elements: `C-c C-k`
;;
;;     Press `C-c C-k` to kill the thing at point and add important
;;     text, without markup, to the kill ring.  Possible things to
;;     kill include (roughly in order of precedece): inline code,
;;     headings, horizonal rules, links (add link text to kill ring),
;;     images (add alt text to kill ring), angle URIs, email
;;     addresses, bold, italics, reference definitions (add URI to
;;     kill ring), footnote markers and text (kill both marker and
;;     text, add text to kill ring), and list items.
;;
;;   * Outline Navigation: `C-c C-n`, `C-c C-p`, `C-c C-f`, `C-c C-b`, and `C-c C-u`
;;
;;     Navigation between headings is possible using `outline-mode'.
;;     Use `C-c C-n` and `C-c C-p` to move between the next and previous
;;     visible headings.  Similarly, `C-c C-f` and `C-c C-b` move to the
;;     next and previous visible headings at the same level as the one
;;     at the point.  Finally, `C-c C-u` will move up to a lower-level
;;     (higher precedence) visible heading.
;;
;;   * Movement by Paragraph or Block: `M-{` and `M-}`
;;
;;     The definition of a "paragraph" is slightly different in
;;     markdown-mode than, say, text-mode, because markdown-mode
;;     supports filling for list items and respects hard line breaks,
;;     both of which break paragraphs.  So, markdown-mode overrides
;;     the usual paragraph navigation commands `M-{` and `M-}` so that
;;     with a `C-u` prefix, these commands jump to the beginning or
;;     end of an entire block of text, respectively, where "blocks"
;;     are separated by one or more lines.
;;
;;   * Movement by Defun: `C-M-a`, `C-M-e`, and `C-M-h`
;;
;;     The usual Emacs commands can be used to move by defuns
;;     (top-level major definitions).  In markdown-mode, a defun is a
;;     section.  As usual, `C-M-a` will move the point to the
;;     beginning of the current or preceding defun, `C-M-e` will move
;;     to the end of the current or following defun, and `C-M-h` will
;;     put the region around the entire defun.
;;
;; As noted, many of the commands above behave differently depending
;; on whether Transient Mark mode is enabled or not.  When it makes
;; sense, if Transient Mark mode is on and the region is active, the
;; command applies to the text in the region (e.g., `C-c C-s s` makes the
;; region bold).  For users who prefer to work outside of Transient
;; Mark mode, since Emacs 22 it can be enabled temporarily by pressing
;; `C-SPC C-SPC`.  When this is not the case, many commands then
;; proceed to look work with the word or line at the point.
;;
;; When applicable, commands that specifically act on the region even
;; outside of Transient Mark mode have the same keybinding as their
;; standard counterpart, but the letter is uppercase.  For example,
;; `markdown-insert-blockquote' is bound to `C-c C-s b` and only acts on
;; the region in Transient Mark mode while `markdown-blockquote-region'
;; is bound to `C-c C-s B` and always applies to the region (when nonempty).
;;
;; Note that these region-specific functions are useful in many
;; cases where it may not be obvious.  For example, yanking text from
;; the kill ring sets the mark at the beginning of the yanked text
;; and moves the point to the end.  Therefore, the (inactive) region
;; contains the yanked text.  So, `C-y` followed by `C-c C-s C-b` will
;; yank text and turn it into a blockquote.
;;
;; markdown-mode attempts to be flexible in how it handles
;; indentation.  When you press `TAB` repeatedly, the point will cycle
;; through several possible indentation levels corresponding to things
;; you might have in mind when you press `RET` at the end of a line or
;; `TAB`.  For example, you may want to start a new list item,
;; continue a list item with hanging indentation, indent for a nested
;; pre block, and so on.  Exdention is handled similarly when backspace
;; is pressed at the beginning of the non-whitespace portion of a line.
;;
;; markdown-mode supports outline-minor-mode as well as org-mode-style
;; visibility cycling for atx- or hash-style headings.  There are two
;; types of visibility cycling: Pressing `S-TAB` cycles globally between
;; the table of contents view (headings only), outline view (top-level
;; headings only), and the full document view.  Pressing `TAB` while the
;; point is at a heading will cycle through levels of visibility for the
;; subtree: completely folded, visible children, and fully visible.
;; Note that mixing hash and underline style headings will give undesired
;; results.

;;; Customization:

;; Although no configuration is *necessary* there are a few things
;; that can be customized.  The `M-x customize-mode` command
;; provides an interface to all of the possible customizations:
;;
;;   * `markdown-command' - the command used to run Markdown (default:
;;     `markdown`).  This variable may be customized to pass
;;     command-line options to your Markdown processor of choice.
;;
;;   * `markdown-command-needs-filename' - set to `t' if
;;     `markdown-command' does not accept standard input (default:
;;     `nil').  When `nil', `markdown-mode' will pass the Markdown
;;     content to `markdown-command' using standard input (`stdin`).
;;     When set to `t', `markdown-mode' will pass the name of the file
;;     as the final command-line argument to `markdown-command'.  Note
;;     that in the latter case, you will only be able to run
;;     `markdown-command' from buffers which are visiting a file.
;;
;;   * `markdown-open-command' - the command used for calling a standalone
;;     Markdown previewer which is capable of opening Markdown source files
;;     directly (default: `nil').  This command will be called
;;     with a single argument, the filename of the current buffer.
;;     A representative program is the Mac app [Marked][], a
;;     live-updating MultiMarkdown previewer which has a command line
;;     utility at `/usr/local/bin/mark`.
;;
;;   * `markdown-hr-strings' - list of strings to use when inserting
;;     horizontal rules.  Different strings will not be distinguished
;;     when converted to HTML--they will all be converted to
;;     `<hr/>`--but they may add visual distinction and style to plain
;;     text documents.  To maintain some notion of promotion and
;;     demotion, keep these sorted from largest to smallest.
;;
;;   * `markdown-bold-underscore' - set to a non-nil value to use two
;;     underscores for bold instead of two asterisks (default: `nil').
;;
;;   * `markdown-italic-underscore' - set to a non-nil value to use
;;     underscores for italic instead of asterisks (default: `nil').
;;
;;   * `markdown-indent-function' - the function to use for automatic
;;     indentation (default: `markdown-indent-line').
;;
;;   * `markdown-indent-on-enter' - set to a non-nil value to
;;     automatically indent new lines when the enter key is pressed
;;     (default: `t')
;;
;;   * `markdown-wiki-link-alias-first' - set to a non-nil value to
;;     treat aliased wiki links like `[[link text|PageName]]`
;;     (default: `t').  When set to nil, they will be treated as
;;     `[[PageName|link text]]'.
;;
;;   * `markdown-uri-types' - a list of protocol schemes (e.g., "http")
;;     for URIs that `markdown-mode' should highlight.
;;
;;   * `markdown-enable-math' - syntax highlighting for LaTeX
;;     fragments (default: `nil').  Set this to `t' to turn on math
;;     support by default.  Math support can be toggled later using
;;     the function `markdown-enable-math'."
;;
;;   * `markdown-css-path' - CSS file to link to in XHTML output
;;     (default: `""`).
;;
;;   * `markdown-content-type' - when set to a nonempty string, an
;;     `http-equiv` attribute will be included in the XHTML `<head>`
;;     block (default: `""`).  If needed, the suggested values are
;;     `application/xhtml+xml` or `text/html`.  See also:
;;     `markdown-coding-system'.
;;
;;   * `markdown-coding-system' - used for specifying the character
;;     set identifier in the `http-equiv` attribute when included
;;     (default: `nil').  See `markdown-content-type', which must
;;     be set before this variable has any effect.  When set to `nil',
;;     `buffer-file-coding-system' will be used to automatically
;;     determine the coding system string (falling back to
;;     `iso-8859-1' when unavailable).  Common settings are `utf-8'
;;     and `iso-latin-1'.
;;
;;   * `markdown-xhtml-header-content' - additional content to include
;;     in the XHTML `<head>` block (default: `""`).
;;
;;   * `markdown-xhtml-standalone-regexp' - a regular expression which
;;     `markdown-mode' uses to determine whether the output of
;;     `markdown-command' is a standalone XHTML document or an XHTML
;;     fragment (default: `"^\\(<\\?xml\\|<!DOCTYPE\\|<html\\)"`).  If
;;     this regular expression not matched in the first five lines of
;;     output, `markdown-mode' assumes the output is a fragment and
;;     adds a header and footer.
;;
;;   * `markdown-link-space-sub-char' - a character to replace spaces
;;     when mapping wiki links to filenames (default: `"_"`).
;;     For example, use an underscore for compatibility with the
;;     Python Markdown WikiLinks extension.  In `gfm-mode', this is
;;     set to `"-"` to conform with GitHub wiki links.
;;
;;   * `markdown-reference-location' - where to insert reference
;;     definitions (default: `header`).  The possible locations are
;;     the end of the document (`end`), after the current block
;;     (`immediately`), before the next header (`header`).
;;
;;   * `markdown-footnote-location' - where to insert footnote text
;;     (default: `end`).  The set of location options is the same as
;;     for `markdown-reference-location'.
;;
;;   * `comment-auto-fill-only-comments' - variable is made
;;     buffer-local and set to `nil' by default.  In programming
;;     language modes, when this variable is non-nil, only comments
;;     will be filled by auto-fill-mode.  However, comments in
;;     Markdown documents are rare and the most users probably intend
;;     for the actual content of the document to be filled.  Making
;;     this variable buffer-local allows `markdown-mode' to override
;;     the default behavior induced when the global variable is non-nil.
;;
;; Additionally, the faces used for syntax highlighting can be modified to
;; your liking by issuing `M-x customize-group RET markdown-faces`
;; or by using the "Markdown Faces" link at the bottom of the mode
;; customization screen.
;;
;; [Marked]: https://itunes.apple.com/us/app/marked/id448925439?ls=1&mt=12&partnerId=30&siteID=GpHp3Acs1Yo

;;; Extensions:

;; Besides supporting the basic Markdown syntax, markdown-mode also
;; includes syntax highlighting for `[[Wiki Links]]` by default.  Wiki
;; links may be followed by pressing `C-c C-o` when the point
;; is at a wiki link.  Use `M-p` and `M-n` to quickly jump to the
;; previous and next links (including links of other types).
;; Aliased or piped wiki links of the form `[[link text|PageName]]`
;; are also supported.  Since some wikis reverse these components, set
;; `markdown-wiki-link-alias-first' to nil to treat them as
;; `[[PageName|link text]]`.
;;
;; [SmartyPants][] support is possible by customizing `markdown-command'.
;; If you install `SmartyPants.pl` at, say, `/usr/local/bin/smartypants`,
;; then you can set `markdown-command' to `"markdown | smartypants"`.
;; You can do this either by using `M-x customize-group markdown`
;; or by placing the following in your `.emacs` file:
;;
;;     (defun markdown-custom ()
;;       "markdown-mode-hook"
;;       (setq markdown-command "markdown | smartypants"))
;;     (add-hook 'markdown-mode-hook '(lambda() (markdown-custom)))
;;
;; [SmartyPants]: http://daringfireball.net/projects/smartypants/
;;
;; Syntax highlighting for mathematical expressions written
;; in LaTeX (only expressions denoted by `$..$`, `$$..$$`, or `\[..\]`)
;; can be enabled by setting `markdown-enable-math' to a non-nil value,
;; either via customize or by placing `(setq markdown-enable-math t)`
;; in `.emacs`, and then restarting Emacs or calling
;; `markdown-reload-extensions'.

;;; GitHub Flavored Markdown:

;; A [GitHub Flavored Markdown][GFM] (GFM) mode, `gfm-mode', is also
;; available.  The GitHub implementation of differs slightly from
;; standard Markdown.  The most important differences are that
;; newlines are significant, triggering hard line breaks, and that
;; underscores inside of words (e.g., variable names) need not be
;; escaped.  As such, `gfm-mode' turns off `auto-fill-mode' and turns
;; on `visual-line-mode' (or `longlines-mode' if `visual-line-mode' is
;; not available).  Underscores inside of words (such as
;; test_variable) will not trigger emphasis.
;;
;; Wiki links in this mode will be treated as on GitHub, with hyphens
;; replacing spaces in filenames and where the first letter of the
;; filename capitalized.  For example, `[[wiki link]]' will map to a
;; file named `Wiki-link` with the same extension as the current file.
;;
;; GFM code blocks, with optional programming language keywords, will
;; be highlighted.  They can be inserted with `C-c C-s P`.  If there
;; is an active region, the text in the region will be placed inside
;; the code block.  You will be prompted for the name of the language,
;; but may press enter to continue without naming a language.
;;
;; For a more complete GitHub-flavored markdown experience, consider
;; adding README.md to your `auto-mode-alist':
;;
;;     (add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))
;;
;; For GFM preview can be powered by setting `markdown-command' to
;; use [Docter][].  This may also be configured to work with [Marked][]
;; for `markdown-open-command'.
;;
;; [GFM]: http://github.github.com/github-flavored-markdown/
;; [Docter]: https://github.com/alampros/Docter

;;; Acknowledgments:

;; markdown-mode has benefited greatly from the efforts of the
;; following people:
;;
;;   * Cyril Brulebois <cyril.brulebois@enst-bretagne.fr> for Debian packaging.
;;   * Conal Elliott <conal@conal.net> for a font-lock regexp patch.
;;   * Edward O'Connor <hober0@gmail.com> for a font-lock regexp fix and
;;     GitHub Flavored Markdown mode (`gfm-mode').
;;   * Greg Bognar <greg_bognar@hms.harvard.edu> for menus and running
;;     `markdown' with an active region.
;;   * Daniel Burrows <dburrows@debian.org> for filing Debian bug #456592.
;;   * Peter S. Galbraith <psg@debian.org> for maintaining `emacs-goodies-el`.
;;   * Dmitry Dzhus <mail@sphinx.net.ru> for undefined reference checking.
;;   * Carsten Dominik <carsten@orgmode.org> for `org-mode', from which the
;;     visibility cycling functionality was derived, and for a bug fix
;;     related to `orgtbl-mode'.
;;   * Bryan Kyle <bryan.kyle@gmail.com> for indentation code.
;;   * Ben Voui <intrigeri@boum.org> for font-lock face customizations.
;;   * Ankit Solanki <ankit.solanki@gmail.com> for `longlines.el`
;;     compatibility and custom CSS.
;;   * Hilko Bengen <bengen@debian.org> for proper XHTML output.
;;   * Jose A. Ortega Ruiz <jao@gnu.org> for Emacs 23 fixes.
;;   * Nelson Minar <nelson@santafe.edu> for `html-helper-mode', from which
;;     comment matching functions were derived.
;;   * Alec Resnick <alec@sproutward.org> for bug reports.
;;   * Joost Kremers <joostkremers@fastmail.fm> for footnote-handling
;;     functions, bug reports regarding indentation, and
;;     fixes for byte-compilation warnings.
;;   * Peter Williams <pezra@barelyenough.org> for `fill-paragraph'
;;     enhancements.
;;   * George Ogata <george.ogata@gmail.com> for fixing several
;;     byte-compilation warnings.
;;   * Eric Merritt <ericbmerritt@gmail.com> for wiki link features.
;;   * Philippe Ivaldi <pivaldi@sfr.fr> for XHTML preview
;;     customizations and XHTML export.
;;   * Jeremiah Dodds <jeremiah.dodds@gmail.com> for supporting
;;     Markdown processors which do not accept input from stdin.
;;   * Werner Dittmann <werner.dittmann@t-online.de> for bug reports
;;     regarding the `cl` dependency and `auto-fill-mode' and indentation.
;;   * Scott Pfister <scott.pfister@gmail.com> for generalizing the space
;;     substitution character for mapping wiki links to filenames.
;;   * Marcin Kasperski <marcin.kasperski@mekk.waw.pl> for a patch to
;;     escape shell commands.
;;   * Christopher J. Madsen <cjm@cjmweb.net> for patches to fix a match
;;     data bug and to prefer `visual-line-mode' in `gfm-mode'.
;;   * Shigeru Fukaya <shigeru.fukaya@gmail.com> for better adherence to
;;     Emacs Lisp coding conventions.
;;   * Donald Ephraim Curtis <dcurtis@milkbox.net> for fixing the `fill-paragraph'
;;     regexp, refactoring the compilation and preview functions,
;;     heading font-lock generalizations, list renumbering,
;;     and kill ring save.
;;   * Kevin Porter <kportertx@gmail.com> for wiki link handling in `gfm-mode'.
;;   * Max Penet <max.penet@gmail.com> and Peter Eisentraut <peter_e@gmx.net>
;;     for an autoload token for `gfm-mode'.
;;   * Ian Yang <me@iany.me> for improving the reference definition regex.
;;   * Akinori Musha <knu@idaemons.org> for an imenu index function.
;;   * Michael Sperber <sperber@deinprogramm.de> for XEmacs fixes.
;;   * Francois Gannaz <francois.gannaz@free.fr> for suggesting charset
;;     declaration in XHTML output.
;;   * Zhenlei Jia <zhenlei.jia@gmail.com> for smart exdention function.
;;   * Matus Goljer <dota.keys@gmail.com> for improved wiki link following
;;     and GFM code block insertion.
;;   * Peter Jones <pjones@pmade.com> for link following functions.
;;   * Bryan Fink <bryan.fink@gmail.com> for a bug report regarding
;;     externally modified files.
;;   * Vegard Vesterheim <vegard.vesterheim@uninett.no> for a bug fix
;;     related to `orgtbl-mode'.
;;   * Makoto Motohashi <mkt.motohashi@gmail.com> for before- and after-
;;     export hooks, unit test improvements, and updates to support
;;     wide characters.
;;   * Michael Dwyer <mdwyer@ehtech.in> for `gfm-mode' underscore regexp.
;;   * Chris Lott <chris@chrislott.org> for suggesting reference label
;;     completion.
;;   * Gunnar Franke <Gunnar.Franke@gmx.de> for a completion bug report.
;;   * David Glasser <glasser@meteor.com> for a `paragraph-separate' fix.
;;   * Daniel Brotsky <dev@brotsky.com> for better auto-fill defaults.

;;; Bugs:

;; Although markdown-mode is developed and tested primarily using
;; GNU Emacs 24, compatibility with earlier Emacsen is also a
;; priority.
;;
;; If you find any bugs in markdown-mode, please construct a test case
;; or a patch and email me at <jrblevin@sdf.org>.

;;; History:

;; markdown-mode was written and is maintained by Jason Blevins.  The
;; first version was released on May 24, 2007.
;;
;;   * 2007-05-24: Version 1.1
;;   * 2007-05-25: Version 1.2
;;   * 2007-06-05: [Version 1.3][]
;;   * 2007-06-29: Version 1.4
;;   * 2007-10-11: [Version 1.5][]
;;   * 2008-06-04: [Version 1.6][]
;;   * 2009-10-01: [Version 1.7][]
;;   * 2011-08-12: [Version 1.8][]
;;   * 2011-08-15: [Version 1.8.1][]
;;   * 2013-01-25: [Version 1.9][]
;;   * 2013-03-24: [Version 2.0][]
;;
;; [Version 1.3]: http://jblevins.org/projects/markdown-mode/rev-1-3
;; [Version 1.5]: http://jblevins.org/projects/markdown-mode/rev-1-5
;; [Version 1.6]: http://jblevins.org/projects/markdown-mode/rev-1-6
;; [Version 1.7]: http://jblevins.org/projects/markdown-mode/rev-1-7
;; [Version 1.8]: http://jblevins.org/projects/markdown-mode/rev-1-8
;; [Version 1.8.1]: http://jblevins.org/projects/markdown-mode/rev-1-8-1
;; [Version 1.9]: http://jblevins.org/projects/markdown-mode/rev-1-9
;; [Version 2.0]: http://jblevins.org/projects/markdown-mode/rev-2-0


;;; Code:

(require 'easymenu)
(require 'outline)
(require 'thingatpt)
(eval-when-compile (require 'cl))


;;; Constants =================================================================

(defconst markdown-mode-version "2.0"
  "Markdown mode version number.")

(defconst markdown-output-buffer-name "*markdown-output*"
  "Name of temporary buffer for markdown command output.")


;;; Global Variables ==========================================================

(defvar markdown-reference-label-history nil
  "History of used reference labels.")


;;; Customizable Variables ====================================================

(defvar markdown-mode-hook nil
  "Hook run when entering Markdown mode.")

(defvar markdown-before-export-hook nil
  "Hook run before running Markdown to export XHTML output.
The hook may modify the buffer, which will be restored to it's
original state after exporting is complete.")

(defvar markdown-after-export-hook nil
  "Hook run after XHTML output has been saved.
Any changes to the output buffer made by this hook will be saved.")

(defgroup markdown nil
  "Major mode for editing text files in Markdown format."
  :prefix "markdown-"
  :group 'wp
  :link '(url-link "http://jblevins.org/projects/markdown-mode/"))

(defcustom markdown-command "markdown"
  "Command to run markdown."
  :group 'markdown
  :type 'string)

(defcustom markdown-command-needs-filename nil
  "Set to non-nil if `markdown-command' does not accept input from stdin.
Instead, it will be passed a filename as the final command line
option.  As a result, you will only be able to run Markdown from
buffers which are visiting a file."
  :group 'markdown
  :type 'boolean)

(defcustom markdown-open-command nil
  "Command used for opening Markdown files directly.
For example, a standalone Markdown previewer.  This command will
be called with a single argument: the filename of the current
buffer."
  :group 'markdown
  :type 'string)

(defcustom markdown-hr-strings
  '("-------------------------------------------------------------------------------"
    "* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *"
    "---------------------------------------"
    "* * * * * * * * * * * * * * * * * * * *"
    "---------"
    "* * * * *")
  "Strings to use when inserting horizontal rules.
The first string in the list will be the default when inserting a
horizontal rule.  Strings should be listed in decreasing order of
prominence (as in headings from level one to six) for use with
promotion and demotion functions."
  :group 'markdown
  :type 'list)

(defcustom markdown-bold-underscore nil
  "Use two underscores for bold instead of two asterisks."
  :group 'markdown
  :type 'boolean)

(defcustom markdown-italic-underscore nil
  "Use underscores for italic instead of asterisks."
  :group 'markdown
  :type 'boolean)

(defcustom markdown-indent-function 'markdown-indent-line
  "Function to use to indent."
  :group 'markdown
  :type 'function)

(defcustom markdown-indent-on-enter t
  "Automatically indent new lines when enter key is pressed.
When this variable is set to t, pressing RET will call
`newline-and-indent'.  When set to nil, define RET to call
`newline' as usual.  In the latter case, you can still use
auto-indentation by pressing \\[newline-and-indent]."
  :group 'markdown
  :type 'boolean)

(defcustom markdown-wiki-link-alias-first t
  "When non-nil, treat aliased wiki links like [[alias text|PageName]].
Otherwise, they will be treated as [[PageName|alias text]]."
  :group 'markdown
  :type 'boolean)

(defcustom markdown-uri-types
  '("acap" "cid" "data" "dav" "fax" "file" "ftp" "gopher" "http" "https"
    "imap" "ldap" "mailto" "mid" "modem" "news" "nfs" "nntp" "pop" "prospero"
    "rtsp" "service" "sip" "tel" "telnet" "tip" "urn" "vemmi" "wais")
  "Link types for syntax highlighting of URIs."
  :group 'markdown
  :type 'list)

(defcustom markdown-enable-math nil
  "Syntax highlighting for inline LaTeX and itex expressions.
Set this to a non-nil value to turn on math support by default.
Math support can be toggled later using `markdown-enable-math'
or \\[markdown-enable-math]."
  :group 'markdown
  :type 'boolean
  :safe 'booleanp)

(defcustom markdown-css-path ""
  "URL of CSS file to link to in the output XHTML."
  :group 'markdown
  :type 'string)

(defcustom markdown-content-type ""
  "Content type string for the http-equiv header in XHTML output.
When set to a non-empty string, insert the http-equiv attribute.
Otherwise, this attribute is omitted."
  :group 'markdown
  :type 'string)

(defcustom markdown-coding-system nil
  "Character set string for the http-equiv header in XHTML output.
Defaults to `buffer-file-coding-system' (and falling back to
`iso-8859-1' when not available).  Common settings are `utf-8'
and `iso-latin-1'.  Use `list-coding-systems' for more choices."
  :group 'markdown
  :type 'coding-system)

(defcustom markdown-xhtml-header-content ""
  "Additional content to include in the XHTML <head> block."
  :group 'markdown
  :type 'string)

(defcustom markdown-xhtml-standalone-regexp
  "^\\(<\\?xml\\|<!DOCTYPE\\|<html\\)"
  "Regexp indicating whether `markdown-command' output is standalone XHTML."
  :group 'markdown
  :type 'regexp)

(defcustom markdown-link-space-sub-char "_"
  "Character to use instead of spaces when mapping wiki links to filenames."
  :group 'markdown
  :type 'string)

(defcustom markdown-reference-location 'header
  "Position where new reference definitions are inserted in the document."
  :group 'markdown
  :type '(choice (const :tag "At the end of the document" end)
                 (const :tag "Immediately after the current block" immediately)
                 (const :tag "Before next header" header)))

(defcustom markdown-footnote-location 'end
  "Position where new footnotes are inserted in the document."
  :group 'markdown
  :type '(choice (const :tag "At the end of the document" end)
                 (const :tag "Immediately after the current block" immediately)
                 (const :tag "Before next header" header)))


;;; Font Lock =================================================================

(require 'font-lock)

(defvar markdown-italic-face 'markdown-italic-face
  "Face name to use for italic text.")

(defvar markdown-bold-face 'markdown-bold-face
  "Face name to use for bold text.")

(defvar markdown-header-delimiter-face 'markdown-header-delimiter-face
  "Face name to use as a base for header delimiters.")

(defvar markdown-header-rule-face 'markdown-header-rule-face
  "Face name to use as a base for header rules.")

(defvar markdown-header-face 'markdown-header-face
  "Face name to use as a base for headers.")

(defvar markdown-header-face-1 'markdown-header-face-1
  "Face name to use for level-1 headers.")

(defvar markdown-header-face-2 'markdown-header-face-2
  "Face name to use for level-2 headers.")

(defvar markdown-header-face-3 'markdown-header-face-3
  "Face name to use for level-3 headers.")

(defvar markdown-header-face-4 'markdown-header-face-4
  "Face name to use for level-4 headers.")

(defvar markdown-header-face-5 'markdown-header-face-5
  "Face name to use for level-5 headers.")

(defvar markdown-header-face-6 'markdown-header-face-6
  "Face name to use for level-6 headers.")

(defvar markdown-inline-code-face 'markdown-inline-code-face
  "Face name to use for inline code.")

(defvar markdown-list-face 'markdown-list-face
  "Face name to use for list markers.")

(defvar markdown-blockquote-face 'markdown-blockquote-face
  "Face name to use for blockquote.")

(defvar markdown-pre-face 'markdown-pre-face
  "Face name to use for preformatted text.")

(defvar markdown-language-keyword-face 'markdown-language-keyword-face
  "Face name to use for programming language identifiers.")

(defvar markdown-link-face 'markdown-link-face
  "Face name to use for links.")

(defvar markdown-missing-link-face 'markdown-missing-link-face
  "Face name to use for links where the linked file does not exist.")

(defvar markdown-reference-face 'markdown-reference-face
  "Face name to use for reference.")

(defvar markdown-footnote-face 'markdown-footnote-face
  "Face name to use for footnote identifiers.")

(defvar markdown-url-face 'markdown-url-face
  "Face name to use for URLs.")

(defvar markdown-link-title-face 'markdown-link-title-face
  "Face name to use for reference link titles.")

(defvar markdown-line-break-face 'markdown-line-break-face
  "Face name to use for hard line breaks.")

(defvar markdown-comment-face 'markdown-comment-face
  "Face name to use for HTML comments.")

(defvar markdown-math-face 'markdown-math-face
  "Face name to use for LaTeX expressions.")

(defvar markdown-metadata-key-face 'markdown-metadata-key-face
  "Face name to use for metadata keys.")

(defvar markdown-metadata-value-face 'markdown-metadata-value-face
  "Face name to use for metadata values.")

(defgroup markdown-faces nil
  "Faces used in Markdown Mode"
  :group 'markdown
  :group 'faces)

(defface markdown-italic-face
  '((t (:inherit font-lock-variable-name-face :slant italic)))
  "Face for italic text."
  :group 'markdown-faces)

(defface markdown-bold-face
  '((t (:inherit font-lock-variable-name-face :weight bold)))
  "Face for bold text."
  :group 'markdown-faces)

(defface markdown-header-rule-face
  '((t (:inherit font-lock-function-name-face :weight bold)))
  "Base face for headers rules."
  :group 'markdown-faces)

(defface markdown-header-delimiter-face
  '((t (:inherit font-lock-function-name-face :weight bold)))
  "Base face for headers hash delimiter."
  :group 'markdown-faces)

(defface markdown-header-face
  '((t (:inherit font-lock-function-name-face :weight bold)))
  "Base face for headers."
  :group 'markdown-faces)

(defface markdown-header-face-1
  '((t (:inherit markdown-header-face)))
  "Face for level-1 headers."
  :group 'markdown-faces)

(defface markdown-header-face-2
  '((t (:inherit markdown-header-face)))
  "Face for level-2 headers."
  :group 'markdown-faces)

(defface markdown-header-face-3
  '((t (:inherit markdown-header-face)))
  "Face for level-3 headers."
  :group 'markdown-faces)

(defface markdown-header-face-4
  '((t (:inherit markdown-header-face)))
  "Face for level-4 headers."
  :group 'markdown-faces)

(defface markdown-header-face-5
  '((t (:inherit markdown-header-face)))
  "Face for level-5 headers."
  :group 'markdown-faces)

(defface markdown-header-face-6
  '((t (:inherit markdown-header-face)))
  "Face for level-6 headers."
  :group 'markdown-faces)

(defface markdown-inline-code-face
  '((t (:inherit font-lock-constant-face)))
  "Face for inline code."
  :group 'markdown-faces)

(defface markdown-list-face
  '((t (:inherit font-lock-builtin-face)))
  "Face for list item markers."
  :group 'markdown-faces)

(defface markdown-blockquote-face
  '((t (:inherit font-lock-doc-face)))
  "Face for blockquote sections."
  :group 'markdown-faces)

(defface markdown-pre-face
  '((t (:inherit font-lock-constant-face)))
  "Face for preformatted text."
  :group 'markdown-faces)

(defface markdown-language-keyword-face
  '((t (:inherit font-lock-type-face)))
  "Face for programming language identifiers."
  :group 'markdown-faces)

(defface markdown-link-face
  '((t (:inherit font-lock-keyword-face)))
  "Face for links."
  :group 'markdown-faces)

(defface markdown-missing-link-face
  '((t (:inherit font-lock-warning-face)))
  "Face for missing links."
  :group 'markdown-faces)

(defface markdown-reference-face
  '((t (:inherit font-lock-type-face)))
  "Face for link references."
  :group 'markdown-faces)

(defface markdown-footnote-face
  '((t (:inherit font-lock-keyword-face)))
  "Face for footnote markers."
  :group 'markdown-faces)

(defface markdown-url-face
  '((t (:inherit font-lock-string-face)))
  "Face for URLs."
  :group 'markdown-faces)

(defface markdown-link-title-face
  '((t (:inherit font-lock-comment-face)))
  "Face for reference link titles."
  :group 'markdown-faces)

(defface markdown-line-break-face
  '((t (:inherit font-lock-constant-face :underline t)))
  "Face for hard line breaks."
  :group 'markdown-faces)

(defface markdown-comment-face
  '((t (:inherit font-lock-comment-face)))
  "Face for HTML comments."
  :group 'markdown-faces)

(defface markdown-math-face
  '((t (:inherit font-lock-string-face)))
  "Face for LaTeX expressions."
  :group 'markdown-faces)

(defface markdown-metadata-key-face
  '((t (:inherit font-lock-variable-name-face)))
  "Face for metadata keys."
  :group 'markdown-faces)

(defface markdown-metadata-value-face
  '((t (:inherit font-lock-string-face)))
  "Face for metadata values."
  :group 'markdown-faces)

(defconst markdown-regex-link-inline
  "\\(!\\)?\\(\\[\\([^]^][^]]*\\|\\)\\]\\)\\((\\([^)]*?\\)\\(?:\\s-+\\(\"[^\"]*\"\\)\\)?)\\)"
  "Regular expression for a [text](file) or an image link ![text](file).
Group 1 matches the leading exclamation point, if any.
Group 2 matchs the entire square bracket term, including the text.
Group 3 matches the text inside the square brackets.
Group 4 matches the entire parenthesis term, including the URL and title.
Group 5 matches the URL.
Group 6 matches (optional) title.")

(defconst markdown-regex-link-reference
  "\\(!\\)?\\(\\[\\([^]^][^]]*\\|\\)\\]\\)[ ]?\\(\\[\\([^]]*?\\)\\]\\)"
  "Regular expression for a reference link [text][id].
Group 1 matches the leading exclamation point, if any.
Group 2 matchs the entire first square bracket term, including the text.
Group 3 matches the text inside the square brackets.
Group 4 matches the entire second square bracket term.
Group 5 matches the reference label.")

(defconst markdown-regex-reference-definition
  "^ \\{0,3\\}\\(\\[[^\n]+?\\]\\):\\s *\\(.*?\\)\\s *\\( \"[^\"]*\"$\\|$\\)"
  "Regular expression for a link definition [id]: ...")

(defconst markdown-regex-footnote
  "\\(\\[\\^.+?\\]\\)"
  "Regular expression for a footnote marker [^fn].")

(defconst markdown-regex-header
  "^\\(?:\\(.+\\)\n\\(=+\\)\\|\\(.+\\)\n\\(-+\\)\\|\\(#+\\)\\s-*\\(.*?\\)\\s-*?\\(#*\\)\\)$"
  "Regexp identifying Markdown headers.")

(defconst markdown-regex-header-1-atx
  "^\\(#\\)[ \t]*\\(.+?\\)[ \t]*\\(#*\\)$"
  "Regular expression for level 1 atx-style (hash mark) headers.")

(defconst markdown-regex-header-2-atx
  "^\\(##\\)[ \t]*\\(.+?\\)[ \t]*\\(#*\\)$"
  "Regular expression for level 2 atx-style (hash mark) headers.")

(defconst markdown-regex-header-3-atx
  "^\\(###\\)[ \t]*\\(.+?\\)[ \t]*\\(#*\\)$"
  "Regular expression for level 3 atx-style (hash mark) headers.")

(defconst markdown-regex-header-4-atx
  "^\\(####\\)[ \t]*\\(.+?\\)[ \t]*\\(#*\\)$"
  "Regular expression for level 4 atx-style (hash mark) headers.")

(defconst markdown-regex-header-5-atx
  "^\\(#####\\)[ \t]*\\(.+?\\)[ \t]*\\(#*\\)$"
  "Regular expression for level 5 atx-style (hash mark) headers.")

(defconst markdown-regex-header-6-atx
  "^\\(######\\)[ \t]*\\(.+?\\)[ \t]*\\(#*\\)$"
  "Regular expression for level 6 atx-st