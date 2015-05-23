# atom-leap package

(Experimental) Leap Motion support for Atom!

This package is being built more as an experiment into what is possible with gesture-based controls in a text editor rather than a tool to be used daily (Although if you are able to then that's a bonus!).

The intention is that it will replace the need for mouse input for Atom thereby reducing the distance needed to travel from the keyboard.

![Leap Motion](https://raw.githubusercontent.com/dan-c-underwood/atom-leap/master/leap.jpg)

## Installation

Installation can be performed within the Atom editor or via the command `apm install atom-leap`.

## Dependencies

Before use you will need to follow the [instructions](https://www.leapmotion.com/setup) to set up your Leap Motion. Once set up you should be good to go!

## Controls

To toggle the Leap Motion controls you will either need to select the menu option under `Packages -> Leap Motion` or press `ctrl + alt + L`.

Currently the only controls are swiping to scroll (as if you were swiping on a touch screen). It's fairly temperamental so don't expect it to be perfect yet!

## Tasks

Features to be worked on:

### Gestures

- [x] Basic Scrolling
- [ ] Switching Tabs
- [ ] Cursor Movement
- [ ] Selection
- [ ] Tree View navigation
- [ ] File Saving
- [ ] File Closing

### UI/Package

- [x] Status Bar indicator
- [ ] Tests!
- [ ] Fancier Status Bar Indicator (colourful & smaller!)
- [ ] Cursor Position
- [ ] Natural scrolling toggle
- [ ] Scroll speed option
