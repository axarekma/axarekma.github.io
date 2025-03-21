# Document names
DOCUMENTS = cv_shortest cv_long
HTMLDOC = cv_shortest
INDEX = index.html
INPUT_DIR = latex

CSS_PATH = moderncv2html/moderncv.css
# Set the correct path for INIT_FILE
CWD := $(shell pwd)
INIT_FILE = $(CWD)/moderncv2html/moderncv.perl
ARGS = 4.0,latin1,unicode

# Default target: Build everything
all: pdf html

# LATEX DEPS
pdf: $(DOCUMENTS:%=$(INPUT_DIR)/%.pdf)

$(INPUT_DIR)/%.pdf: $(INPUT_DIR)/%.tex
	cd $(INPUT_DIR) && latexmk -pdf -quiet $*.tex

# LATEX2HTML DEPS
$(INPUT_DIR)/$(HTMLDOC)/index.html: $(INPUT_DIR)/$(HTMLDOC).tex
	cd $(INPUT_DIR) && latex2html -style "$(CSS_PATH)" -init_file "$(INIT_FILE)" "$(HTMLDOC).tex" -html_version "$(ARGS)"

index.html: $(INPUT_DIR)/$(HTMLDOC)/index.html
	cp $(INPUT_DIR)/$(HTMLDOC)/index.html ./index.html

html: ./index.html

# Cleanup
clean:
	rm -rf $(DOCUMENTS:%=$(INPUT_DIR)/%)  # Remove HTML directory
	cd $(INPUT_DIR) && latexmk -c         # Cleanup temp files

.PHONY: clean all pdf
