module glad.gl.types;


alias GLbitfield = uint;
alias GLclampx = int;
alias GLuint64 = ulong;
alias GLvoid = void;
alias GLcharARB = byte;
alias GLhalf = ushort;
alias GLint64 = long;
alias GLint = int;
alias GLhandleARB = uint;
alias GLsizeiptr = ptrdiff_t;
alias GLbyte = byte;
alias GLfixed = int;
alias GLenum = uint;
alias GLhalfNV = ushort;
alias GLclampf = float;
alias GLvdpauSurfaceNV = ptrdiff_t;
alias GLdouble = double;
alias GLintptr = ptrdiff_t;
alias GLclampd = double;
alias GLeglImageOES = void*;
alias GLhalfARB = ushort;
alias GLfloat = float;
alias GLsizeiptrARB = ptrdiff_t;
alias GLushort = ushort;
alias GLboolean = ubyte;
alias GLuint64EXT = ulong;
alias GLchar = char;
alias GLint64EXT = long;
alias GLshort = short;
alias GLuint = uint;
alias GLubyte = ubyte;
alias GLintptrARB = ptrdiff_t;
alias GLsizei = int;
struct ___GLsync; alias __GLsync = ___GLsync*;
alias GLsync = __GLsync*;
struct __cl_context; alias _cl_context = __cl_context*;
struct __cl_event; alias _cl_event = __cl_event*;
extern(System) {
alias GLDEBUGPROC = void function(GLenum, GLenum, GLuint, GLenum, GLsizei, in GLchar*, GLvoid*);
alias GLDEBUGPROCARB = GLDEBUGPROC;
alias GLDEBUGPROCKHR = GLDEBUGPROC;
alias GLDEBUGPROCAMD = void function(GLuint, GLenum, GLenum, GLsizei, in GLchar*, GLvoid*);
}
