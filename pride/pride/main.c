#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdbool.h>

#include <buildin/number_parser.h>

#include <foxos/term.h>

typedef struct flag_part {
	uint32_t color;
	int height;
} flag_part_t;

enum flags_e {
	FLAG_GAY,
	FLAG_BI,
	FLAG_TRANS,
	FLAG_RAINBOW,
	END
};

flag_part_t* flags[END];
char* flag_names[END] = {
	[FLAG_GAY] = "gay",
	[FLAG_BI] = "bi",
	[FLAG_TRANS] = "trans",
	[FLAG_RAINBOW] = "rainbow"
};

#define arg_str(name) char* name = NULL; for (int i = 1; i < argc; i++) { if (strcmp(argv[i], "--"#name) == 0) { name = argv[i + 1]; break; } }
#define arg(name) bool name = false; for (int i = 1; i < argc; i++) { if (strcmp(argv[i], "--"#name) == 0) { name = true; break; } }

void usage(char* argv0) {
	printf("Usage: %s [--flag <flag>] [--scale <scale>]\n", argv0);
	printf("The following flags are available:\n");
	for (int i = 0; i < END; i++) {
		printf(" > %s\n", flag_names[i]);
	}
}

int main (int argc, char** argv) {
	flags[FLAG_GAY] = (flag_part_t[]) { { 0x238d70, 2 }, { 0x3ecea9, 2 }, { 0x9be8c0, 2 }, { 0xFFFFFF, 2 }, { 0x7faae0, 2 }, { 0x5643c9, 2 }, { 0x411876, 2 }, { 0, 0 }};
	flags[FLAG_BI] = (flag_part_t[]) { { 0xD60270, 4 }, { 0x9B4F96, 3 }, { 0x0038A8, 4 }, { 0, 0 } };
	flags[FLAG_TRANS] = (flag_part_t[]) { { 0x5BCFFB, 2 }, { 0xF5ABB9, 2 }, { 0xFFFFFF, 2 }, { 0xF5ABB9, 2 }, { 0x5BCFFB, 2 }, { 0, 0 }};
	flags[FLAG_RAINBOW] = (flag_part_t[]) { { 0xE50000, 2 }, { 0xFF8D00, 2 }, { 0xFFEE00, 2 }, { 0x028121, 2 }, { 0x004CFF, 2 }, { 0x770088, 2 }, { 0, 0 } };

	arg_str(flag);
	arg_str(scale);
	arg(help);

	if (help) {
		usage(argv[0]);
		return 0;
	}

	int flag_flag = FLAG_GAY;
	if (flag) {
		for (int i = 0; i < END; i++) {
			if (strcmp(flag, flag_names[i]) == 0) {
				flag_flag = i;
				break;
			}
		}
	} else {
		usage(argv[0]);
		return -1;
	}

	int flag_scale = 1;
	if (scale) {
		__libc_parse_number(scale, &flag_scale);
	} else {
		int full_height = 0;
		for (int i = 0; flags[flag_flag][i].height != 0; i++) {
			full_height += flags[flag_flag][i].height;
		}
		flag_scale = ((get_screen_size().y / 16) - 2) / full_height;
	}

	uint32_t old_color = get_color();

	int idx = 0;
	while (flags[flag_flag][idx].height != 0) {
		set_color(flags[flag_flag][idx].color);
		for (int i = 0; i < flags[flag_flag][idx].height * flag_scale; i++) {
			for (int j = 0; j < (get_screen_size().x / 8) - 1; j++) {
				putchar('X');
			}
			putchar('\n');
		}
		idx++;
	}

	set_color(old_color);

	return 0;
}