default: run

clean:
	@[[ ! -e astar.love ]] || rm astar.love
	@[[ ! -e pkg ]] || rm -r pkg        

build: clean
	@cd src/ && zip -r ../astar.love *

run: build
	@love astar.love
