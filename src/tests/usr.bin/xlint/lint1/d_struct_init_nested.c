/*	$NetBSD: d_struct_init_nested.c,v 1.4 2021/02/21 09:07:58 rillig Exp $	*/
# 3 "d_struct_init_nested.c"

/*
 * Initialization of a nested struct, in which some parts are initialized
 * from non-constant expressions of the inner struct type.
 *
 * In C99, 6.7.8p13 describes exactly this case.
 */

typedef enum O1 { O1C = 101 } O1;
typedef enum O2 { O2C = 102 } O2;
typedef enum O3 { O3C = 103 } O3;
typedef enum I1 { I1C = 201 } I1;
typedef enum I2 { I2C = 202 } I2;

struct Inner1 {
	I1 i1;
};

struct Outer3Inner1 {
	O1 o1;
	struct Inner1 inner;
	O3 o3;
};

O1
funcOuter3Inner1(void)
{
	struct Inner1 inner = {
		I1C
	};
	struct Outer3Inner1 o3i1 = {
	    O1C,
	    inner,		/*FIXME*//* expect: 185 */
	    O3C
	};			/*FIXME*//* expect: 172 */

	return o3i1.o1;
}

struct Inner2 {
	I1 i1;
	I2 i2;
};

struct Outer3Inner2 {
	O1 o1;
	struct Inner2 inner;
	O3 o3;
};

O1
funcOuter3Inner2(void)
{
	struct Inner2 inner = {
		I1C,
		I2C
	};
	struct Outer3Inner2 o3i2 = {
	    O1C,
	    inner,		/*FIXME*//* expect: 185 */
	    O3C
	};			/*FIXME*//* expect: 210 */
/* FIXME: warning 210 must print the type names to be any useful */
	return o3i2.o1;
}
