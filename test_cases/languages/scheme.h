// SCHEME LANGUAGE SPECIFICATION

#define LANGUAGE    "SCHEME"
#define DIMENSION   2

#define SEPARATOR   " "
#define BEGIN_VEC   "(vector "
#define END_VEC     ")"
#define BEGIN_POS   "("
#define END_POS     "("

#undef  TYPED
#undef  TYPE

#undef  ASSIGNED
#undef  ASSIGN

#undef  PRESIZED
#undef  POSTSIZED

#undef  PRENAMED
#define POSTNAMED

#define DEFINED
#define BEGIN_DEFINE "(define"
#define END_DEFINE   ")"

#undef  SIZE

#define BEGIN_BOARD  "(vector "
#define END_BOARD    ")"
#define NAME         " board "