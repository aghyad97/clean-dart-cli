abstract class IGeneratePresentation {
  Future<bool> call(String presentationPage, String path,
      String routesJsonFilePath, String routesDartFilePath);
}
