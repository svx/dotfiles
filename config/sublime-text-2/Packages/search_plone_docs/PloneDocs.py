# Written by Jad Bitar (@jadb / www.jadbitar.com) addopted by Sven Strack

# available commands
#   plonedocs_search_selection
#   plonedocs_search_from_input

# changelog
# Jad Bitar - first implementation of search selection and search from input
# Sven Strack, addopted for plone docs

import sublime
import sublime_plugin

import subprocess
import webbrowser

def SearchFor(text):
    url = 'http://developer.plone.org/search.html?q=' + text.replace(' ','%20')
    webbrowser.open_new_tab(url)

class plonedocsSearchSelectionCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        for selection in self.view.sel():
            # if the user didn't select anything, search the currently highlighted word
            if selection.empty():
                text = self.view.word(selection)

            text = self.view.substr(selection)

            SearchFor(text)

class plonedocsSearchFromInputCommand(sublime_plugin.WindowCommand):
    def run(self):
        # Get the search item
        self.window.show_input_panel('Search PloneDocs for', '',
            self.on_done, self.on_change, self.on_cancel)
    def on_done(self, input):
        SearchFor(input)

    def on_change(self, input):
        pass

    def on_cancel(self):
        pass
