SRC =  src/main.c

NAME = cub3D
OBJ = $(SRC:.c=.o)
CC = cc
RM = rm -rf
CFLAGS = -Wall -Wextra -Werror -I ./inc
MINILIBX = libs/minilibx-linux/libmlx.a
LIBFT = libs/libft/*.c

Reset = \033[0m
G = \033[32m
R = \033[31m
Y = \033[33m
blink = \033[6;7;1;3m
ascii = /nfs/homes/kneves/local/bin/./cbonsai -l -t 0.006 -m "Cub3D" -p

all: $(NAME)

$(NAME): $(OBJ)
	@ make -C ./libs/minilibx-linux
	@ make -C ./libs/libft
	@ $(CC) $(CFLAGS) $(OBJ) -o $(NAME) $(LIBFT) $(MINILIBX) -lXext -lX11 -lm #-lz
	-@$(ascii)
	@echo "-------------------------------------------------------------------------------------"
	@echo "$(blink)$(G) ✅ $(NAME) successfully compiled $(Reset)"
	@echo "$(G)-------------------------------------------------------------------------------------$(Reset)"

%.o: %.c
	@$(CC) $(CFLAGS) -c $< -o $@

val:
	valgrind --leak-check=full ./cub3D

normalclean:
	-@$(RM) $(OBJ)

clean: normalclean
	-@$(RM) $(OBJ)
	@echo "$(Y)-------------------------------------------------------------------------------------"
	@echo " 😉 Objects from the $(NAME) project have been removed"
	@echo "-------------------------------------------------------------------------------------$(Reset)"

fclean: normalclean
	@echo "$(R)"
	-@timeout 3 curl parrot.live 	
	@$(RM) $(NAME)
	@echo "-------------------------------------------------------------------------------------"
	@echo "$(blink)$(R) ❌ removed $(NAME) executable $(Reset)"
	@echo "$(R)-------------------------------------------------------------------------------------$(Reset)"

re: normalclean all

.PHONY: all clean fclean re
