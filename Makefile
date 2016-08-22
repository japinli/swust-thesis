.PHONY: cls doc clean distclean main all

NAME = swustthesis

all: cls doc main

main: main.tex cls
	latexmk -xelatex $<

cls: $(NAME).cls

doc: $(NAME).pdf

$(NAME).cls: $(NAME).ins $(NAME).dtx
	xetex $<

$(NAME).pdf: $(NAME).dtx
	latexmk -xelatex $<

clean:
	@latexmk -c
	@latexmk -c $(NAME).dtx

distclean:
	@latexmk -C
	@latexmk -C $(NAME).dtx
