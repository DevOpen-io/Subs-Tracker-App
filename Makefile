changeIcon: 
	flutter pub run flutter_launcher_icons

cleanRun:
	flutter clean
	flutter run

run:
	flutter run

debugApk:
	flutter build apk --debug

profileApk:
	flutter build apk --profile

releaseApk:
	flutter build apk --release

runnerBuild:
	dart run build_runner build -d