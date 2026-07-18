allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
// Some plugins (e.g. file_picker 8.x) still compile against an older Android
// API than a transitive dependency (flutter_plugin_android_lifecycle) now
// requires (compileSdk 36). Force every Android subproject to the app's
// compileSdk so the AAR-metadata check passes. Registered before the
// evaluationDependsOn below so no subproject is evaluated yet. Reflection
// keeps this working across AGP versions (AGP 9 removed several deprecated
// DSL types).
subprojects {
    afterEvaluate {
        val android = extensions.findByName("android") ?: return@afterEvaluate
        val methods = android.javaClass.methods
        val setCompileSdk = methods.firstOrNull {
            it.name == "setCompileSdk" && it.parameterTypes.size == 1
        }
        if (setCompileSdk != null) {
            setCompileSdk.invoke(android, 36)
        } else {
            methods.firstOrNull {
                it.name == "compileSdkVersion" &&
                    it.parameterTypes.size == 1 &&
                    it.parameterTypes[0] == Integer.TYPE
            }?.invoke(android, 36)
        }
    }
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
