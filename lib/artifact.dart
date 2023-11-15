class Artifact {
  String name;
  int amount;
  String description;

  static List<Artifact> databaseArtifact = [];

  Artifact(this.name, this.amount, this.description) {
    databaseArtifact.add(this);
  }
}