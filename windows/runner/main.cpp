#include <flutter/dart_project.h>
#include <flutter/flutter_view_controller.h>
#include <windows.h>

#include <memory>
#include <string>

int APIENTRY wWinMain(_In_ HINSTANCE instance, _In_opt_ HINSTANCE prev,
                      _In_ wchar_t *command_line, _In_ int show_command) {
  // Attach to console when present (e.g., 'flutter run') or create a new console
  // when running with a debugger.
  if (!::AttachConsole(ATTACH_PARENT_PROCESS) && ::IsDebuggerPresent()) {
    ::AllocConsole();
  }

  // Initialize COM, so the system is able to use drag and drop.
  ::CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED);

  flutter::DartProject project(L"data");

  std::vector<std::string> command_line_arguments =
      flutter::FlutterViewController::GetCommandLineArguments();

  flutter::FlutterViewController::ViewProperties view_properties = {};
  view_properties.title = L"LAN File Share";
  view_properties.width = 800;
  view_properties.height = 600;

  flutter::FlutterViewController flutter_controller(project);
  if (!flutter_controller.Create(view_properties)) {
    return EXIT_FAILURE;
  }
  flutter_controller.SetInitialRoute("/");
  flutter_controller.Run();

  ::CoUninitialize();
  return EXIT_SUCCESS;
}