// 下列 ifdef 块是创建使从 DLL 导出更简单的
// 宏的标准方法。此 DLL 中的所有文件都是用命令行上定义的 BENCHMARK2008_EXPORTS
// 符号编译的。在使用此 DLL 的
// 任何其他项目上不应定义此符号。这样，源文件中包含此文件的任何其他项目都会将
// BENCHMARK2008_API 函数视为是从 DLL 导入的，而此 DLL 则将用此宏定义的
// 符号视为是被导出的。
#ifdef _WIN32
#ifdef BENCHMARK2008_EXPORTS
#define BENCHMARK2008_API __declspec(dllexport)
#else
#define BENCHMARK2008_API __declspec(dllimport)
#endif
#else
#define BENCHMARK2008_API
#endif

#define min(a, b) ((a) < (b) ? (a) : (b))
#define max(a, b) ((a) > (b) ? (a) : (b))
#define abss(a)     (a<0 ? (-a) : a)

BENCHMARK2008_API void Shifted_Sphere(double *f, double* x, int n, int dim);
BENCHMARK2008_API void Schwefel_Problem(double *f, double* x, int n, int dim);
BENCHMARK2008_API void Shifted_Rosenbrock(double *f, double* x, int n, int dim);
BENCHMARK2008_API void Shifted_Rastrigin(double *f, double* x, int n, int dim);
BENCHMARK2008_API void Shifted_Griewank(double *f, double* x, int n, int dim);
BENCHMARK2008_API void Shifted_Ackley(double *f, double* x, int n, int dim);

