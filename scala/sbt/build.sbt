import Dependencies._

lazy val root = (project in file(".")).
  settings(
    inThisBuild(List(
      organization := "com.binary.ws",
      scalaVersion := "2.12.6",
      version      := "0.1.0-SNAPSHOT"
    )),
    name := "binaryws",
    assemblyJarName in assembly := "binaryws.jar",
    assemblyMergeStrategy in assembly := {
      case PathList(ps @ _*) if ps.last endsWith "io.netty.versions.properties" =>
        MergeStrategy.discard
      case x =>
        val oldStrategy =(assemblyMergeStrategy in assembly).value
        oldStrategy(x)
    },
    libraryDependencies += wsClient % Compile,
    libraryDependencies += scalaTest % Test
  )
