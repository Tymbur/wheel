<!-- vim: set filetype=markdown: -->

# Work in progress

The core functionality begins to work. A lot of extras has to be done.

## TODO

- commands with arguments
  + WheelNext [torus|circle|location]
  + WheelPrev [torus|circle|location]
  + WheelSwitch [torus|circle|location]

# Introduction

Wheel is a plugin for vim or neovim aimed at managing buffer groups.

In short, this plugin let you organize your buffers by creating as
many buffer groups as you need, add the buffers you want to it and
quickly navigate between :

- Buffers of the same group
- Buffer groups

Note that :

- A location contains a name, a filename, as well as a line & column number
- A buffer group, in fact a location group, is called a circle
- A set of buffer groups is called a torus (a circle of circles)
- The list of toruses is called the wheel

## Why do you need three levels of grouping ?

At first glance, managing groups with circles in a torus seems to
be sufficient. But with time, the torus grows big, and a third level
helps you to organize your files by groups and categories:

  - The wheel contains all the toruses
  - Each torus contains a category of files, e.g.:
    + configuration, development, publication
  - Each circle contains a project, e.g.:
    + emacs or vifm circles in configuration torus
    + shell or elisp in development torus
    + tea or art in publication torus

## History

This project is inspired by :

- [CtrlSpace](https://github.com/vim-ctrlspace/vim-ctrlspace), a similar
plugin for Vim

- [Torus](https://github.com/chimay/torus), a similar plugin for Emacs,
itself inspired by MTorus

## Goal

Torus helps you to organize your files in groups that you create
yourself, following your workflow. You only add the files you want,
where you want. For instance, if you have a "organize" group with
agenda & todo files, you can quickly alternate them, or display them
in two windows. Then, if you suddenly got an idea to tune emacs, you
switch to the "emacs" group with your favorites configuration files in
it. Same process, to cycle, alternate or display the files. Note that
the toruses containing all these groups can be saved on a file and
loaded later. Over time, your groups will grow and adapt to your
style.

# Step by Step


## First Circles

Let’s say we have the files `Juice`, `Tea`, `Coffee`. We can add them
to the torus with `TODO`. If this is your first torus or
circle, it will ask names for them. So, we go to `Juice` and use
`TODO`. Let’s say we name the torus `Food` and the circle
`Drinks`. Then, we go to `Tea` and add it to `Drinks` using the same
function. Same process with `Coffee`. We now have a circle `Drink`
containing three files.

If your files are not already opened in buffers, just use
`TODO` to add them in the circle.

If you want to create another circle, let’s say `Fruits`, simply
launch `TODO` again, and enter another name. You can then
add the files `Apple`, `Pear` and `Orange` to it. You can even also
add `Juice`, a file can be added to more than one circle.

Now, suppose that in the `Juice` file, you have a Pineapple and a
Mango sections, and you want to compare them. Just go to the Pineapple
section, use `TODO`. It will add the location
(`Juice . pineapple-position`) to the current circle. Then, go to the
Mango section, and do the same. The (`Juice . mango-position`) will
also be added to the circle. You can then easily alternate both, or
display them in split windows.


## Moving around

You can cycle the files of a circle with `TODO` and
`TODO`. You can also switch file with completion by using
`TODO`. It works well with Helm.

To cycle the circles, use `TODO` and
`TODO`. To go to a given circle with completion, use
`TODO`.

Same thing to cycle the toruses, with `TODO` and
`TODO`. To go to a given torus with completion, use
`TODO`.


## Square the Circle

Over time, the number of circles will grow. Completion is great, but
if you just want to alternate the two last circles in history, you’ll
probably prefer `TODO`. You can
also alternate two last files inside the same circle with
`TODO`. So, you have the square :

| circle 1, file 1 | circle 1, file 2 |
| circle 2, file 3 | circle 2, file 4 |

at your fingertips.

Finally, `TODO` alternate two last history
files, regardless of their circles.


## Splits

If you prefix a torus navigation function by C-u, the asked file will
be opened in a new window below. With C-u C-u, it will be in a new
window on the right.

If you want to see all the circle files in separate windows, use
`TODO` and chose between horizontal, vertical or grid
splits. You also have layouts with main window on left, right, top or
bottom side.

Your choice is remembered by torus for the current circle. You can
swith back to one window using the same layout function. The special
choice "manual" ask Torus not to interfere in your layout.

The maximum number of windows generated by the split functions
are conxtrolled by the vars `TODO` and
`TODO`.

# Licence

MIT
