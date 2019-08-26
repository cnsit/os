int64_t string_to_int(const char* str, const int32_t len) {
	if (*str == 0) return 0xffffffff; //null
	int32_t exp = len;
	if (len == 0) {
		const char* backup = str;
		while (*backup != 0) {
			backup++;
		}
		exp = backup - str;
	}
	int64_t res = 0;
	for (int32_t i = 0; i < exp; i++) {
		res = res * 10 + str[i] - 0x30;
	}
	return res;
}
int64_t string_to_binary(char* str) {
	//17.1890 => 1.71890
	//0.71890 => binary

	//0.53410 => binary
	//.53410 => binary
	if (*str == 0)return 0xffffffff; //empty string
	int64_t df = 0;
	if (*str == 0x2d) {
		df |= 0x80000000; //negative sign
		str++;
	}
	else if (*str == 0x2b) {
		str++; //positive sign, nothing else to do
	}
	char* backup = str;
	char man[20], ex = 0;
	int32_t index = 0;
	int32_t exp = 0; //exp to move integer part (0, 10)
	while (*str!= 0) {
		char s = *str;
		if (s == 0x2e) { //.
			exp = str - backup - 1;
			if (exp > 0) {
				ex = *backup;
			}
			while ((backup + 1) < str) {
				man[index++] = backup[1];
				backup++;
			}
			str++;
			while (*str != 0) {
				man[index++] = *str;
				str++;
			}
			man[index] = 0;
			break;

		}
		str++;
	}
	int64_t integer_part = string_to_int(&ex, 1);
	int64_t decimal_part = string_to_int(man, 0);
	std::cout << integer_part << "." << decimal_part << "e" << exp;
	return decimal_part;
}
