# vscode-flutter-android

# osm map

https://github.com/edwinmacalopu/OpenStreetMap-flutter

```
flutter pub add flutter_map latlong2 geolocator
```

# permission

'.android/app/src/main/AndroidManifest.xml'

```

<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />

<application
```

# build bundle, edit, build apk

```
flutter build bundle 
```

**edit**

`code /home/node/ws/.android/Flutter/build.gradle`

```

android {
    compileSdkVersion 33
    ndkVersion flutter.ndkVersion

```


`code .android/app/build.gradle`

```

android {
    compileSdkVersion 33

```


`code .android/app/src/main/AndroidManifest.xml`

```

<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />

<application
```


```
flutter build apk
```