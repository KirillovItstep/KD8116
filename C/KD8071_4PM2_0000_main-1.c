/*
 * MATLAB Compiler: 4.10 (R2009a)
 * Date: Sat Feb 25 19:35:50 2012
 * Arguments: "-B" "macro_default" "-m" "-W" "main" "-T" "link:exe"
 * "KD8071_4PM2_0000" "BEGIn_Callback" "Exit_my" "Im_KD8071" "Line_strelka"
 * "Line_strelka1" "Line_strelka4" "menu_KD8071" "METKI" "NEXt_Callback"
 * "my_inputdlg" 
 */

#include <stdio.h>
#include "mclmcrrt.h"
#ifdef __cplusplus
extern "C" {
#endif

extern mclComponentData __MCC_KD8071_4PM2_0000_component_data;

#ifdef __cplusplus
}
#endif

static HMCRINSTANCE _mcr_inst = NULL;


#ifdef __cplusplus
extern "C" {
#endif

static int mclDefaultPrintHandler(const char *s)
{
  return mclWrite(1 /* stdout */, s, sizeof(char)*strlen(s));
}

#ifdef __cplusplus
} /* End extern "C" block */
#endif

#ifdef __cplusplus
extern "C" {
#endif

static int mclDefaultErrorHandler(const char *s)
{
  int written = 0;
  size_t len = 0;
  len = strlen(s);
  written = mclWrite(2 /* stderr */, s, sizeof(char)*len);
  if (len > 0 && s[ len-1 ] != '\n')
    written += mclWrite(2 /* stderr */, "\n", sizeof(char));
  return written;
}

#ifdef __cplusplus
} /* End extern "C" block */
#endif

/* This symbol is defined in shared libraries. Define it here
 * (to nothing) in case this isn't a shared library. 
 */
#ifndef LIB_KD8071_4PM2_0000_C_API 
#define LIB_KD8071_4PM2_0000_C_API /* No special import/export declaration */
#endif

LIB_KD8071_4PM2_0000_C_API 
bool MW_CALL_CONV KD8071_4PM2_0000InitializeWithHandlers(
    mclOutputHandlerFcn error_handler,
    mclOutputHandlerFcn print_handler
)
{
  if (_mcr_inst != NULL)
    return true;
  if (!mclmcrInitialize())
    return false;
  if (!mclInitializeComponentInstanceWithEmbeddedCTF(&_mcr_inst,
                                                     &__MCC_KD8071_4PM2_0000_component_data,
                                                     true, NoObjectType,
                                                     ExeTarget, error_handler,
                                                     print_handler, 10025264, NULL))
    return false;
  return true;
}

LIB_KD8071_4PM2_0000_C_API 
bool MW_CALL_CONV KD8071_4PM2_0000Initialize(void)
{
  return KD8071_4PM2_0000InitializeWithHandlers(mclDefaultErrorHandler,
                                                mclDefaultPrintHandler);
}

LIB_KD8071_4PM2_0000_C_API 
void MW_CALL_CONV KD8071_4PM2_0000Terminate(void)
{
  if (_mcr_inst != NULL)
    mclTerminateInstance(&_mcr_inst);
}

int run_main(int argc, const char **argv)
{
  int _retval;
  /* Generate and populate the path_to_component. */
  char path_to_component[(PATH_MAX*2)+1];
  separatePathName(argv[0], path_to_component, (PATH_MAX*2)+1);
  __MCC_KD8071_4PM2_0000_component_data.path_to_component = path_to_component; 
  if (!KD8071_4PM2_0000Initialize()) {
    return -1;
  }
  argc = mclSetCmdLineUserData(mclGetID(_mcr_inst), argc, argv);
  _retval = mclMain(_mcr_inst, argc, argv, "KD8071_4PM2_0000", 0);
  if (_retval == 0 /* no error */) mclWaitForFiguresToDie(NULL);
  KD8071_4PM2_0000Terminate();
  mclTerminateApplication();
  return _retval;
}

int main(int argc, const char **argv)
{
  if (!mclInitializeApplication(
    __MCC_KD8071_4PM2_0000_component_data.runtime_options,
    __MCC_KD8071_4PM2_0000_component_data.runtime_option_count))
    return 0;
  
  return mclRunMain(run_main, argc, argv);
}
