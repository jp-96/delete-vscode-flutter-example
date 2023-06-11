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

# copy android config files

```
cd ~/ws
cp -rf ./.configfiles/.android ./
```


```
flutter build apk
```

# realm example - Shopping List application

https://betterprogramming.pub/building-an-offline-app-with-mongodb-realm-8d4d00f8646f

```
flutter pub add realm
flutter pub get
```


Generate Schema from the RealmModel class

`./lib/schemas/item.dart` --> `./lib/schemas/item.g.dart`

```
flutter pub run realm generate
```

ItemService - Working with Realm

`lib/services/item_service.dart`

- Configure and Open a Realm
- Read all Items
- Write an Item
- Update an Item
- Delete an Item

ItemListView

- items - A list of Item objects
- onToggle - A callback function to be invoked when an item is toggled
- onDelete - A callback function to be invoked when an item is deleted

AddItemView

- onAdd - A callback function to be invoked when an item is added

ShoppingListView

- onAdd - A callback function to be invoked when an item is added
- onToggle - A callback function to be invoked when an item is toggled
- onDelete - A callback function to be invoked when an item is deleted
- items - A list of Item objects
