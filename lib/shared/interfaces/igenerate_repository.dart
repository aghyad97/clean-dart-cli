abstract class IGenerateRepository {
  Future<bool> call(String repositoryName, String domainPath, String dataPath);
}
