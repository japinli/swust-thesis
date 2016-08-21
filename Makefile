.PHONY: cls doc clean distclean main all

NAME = swustthesis

main: cls

all: cls doc

cls: $(NAME).cls

doc: $(NAME).pdf

$(NAME).cls: $(NAME).ins
	xetex $<

$(NAME).pdf: $(NAME).dtx
	latexmk -xelatex $<

clean:
	@latexmk -c
	@latexmk -c $(NAME).dtx

distclean:
	@latexmk -C
	@latexmk -C $(NAME).dtx
