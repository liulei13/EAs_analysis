// ���� ifdef ���Ǵ���ʹ�� DLL �������򵥵�
// ��ı�׼�������� DLL �е������ļ��������������϶���� BENCHMARK2008_EXPORTS
// ���ű���ġ���ʹ�ô� DLL ��
// �κ�������Ŀ�ϲ�Ӧ����˷��š�������Դ�ļ��а������ļ����κ�������Ŀ���Ὣ
// BENCHMARK2008_API ������Ϊ�Ǵ� DLL ����ģ����� DLL ���ô˺궨���
// ������Ϊ�Ǳ������ġ�
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
