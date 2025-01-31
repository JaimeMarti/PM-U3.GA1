import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:u3_ga1/main.dart';

Future<T?> loadingDialog<T>(BuildContext context, Future<T> future) {
  return showDialog<T>(
    context: context,
    builder: (context) {
      return FutureBuilder(
        future: future,
        builder: (context2, snapshot) {
          if(snapshot.connectionState == ConnectionState.done) {
            if(!snapshot.hasError) {
              context.pop(snapshot.data);
            }
            else {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Error: ${snapshot.error}"),
                      TextButton(
                        onPressed: () {
                          context.pop(null);
                        },
                        child: const Text("Ok"),
                      )
                    ]
                  )
                )
              );
            }
          }
          return UnconstrainedBox(
            child: SizedBox(
              width: 100.0,
              height: 100.0,
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                insetPadding: EdgeInsets.zero,
                child: const SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CircularProgressIndicator()
                  )
                )
              )
            )
          );
        }
      );
    }
  );
}

DatabaseReference _favoriteRef(int province, int county) {
  return database.ref("users/${auth.currentUser!.uid}/favorites/${province}_$county");
}

DatabaseReference _favoritesRef() {
  return database.ref("users/${auth.currentUser!.uid}/favorites");
}

Future<void> addFavorite(int province, int county) {
  DatabaseReference ref = _favoriteRef(province, county);
  return ref.set(true);
}

Future<void> removeFavorite(int province, int county) {
  DatabaseReference ref = _favoriteRef(province, county);
  return ref.remove();
}

Stream<Iterable<CountyId>> getFavoritesStream() {
  DatabaseReference ref = _favoritesRef();
  return ref.onValue.map((event) {
    Object? value = event.snapshot.value;
    if(value != null && value is Map<Object?, Object?>) {
      return value.entries
        .where((entry) {
          Object? value = entry.value;
          if(value != null && value is bool) {
            return value;
          }
          else {
            return false;
          }
        })
        .map((entry) {
          Object? key = entry.key;
          if(key != null && key is String) {
            List<String> parts = key.split("_");
            int province = int.parse(parts[0]);
            int county = int.parse(parts[1]);
            return CountyId(province, county);
          }
          else {
            return CountyId(0, 0);
          }
        });
    }
    else {
      return const Iterable.empty();
    }
  });
}

Future<bool> isFavorite(int province, int county) async {
  DatabaseReference ref = _favoriteRef(province, county);
  Object? value = (await ref.get()).value;
  if(value != null && value is bool) {
    return value;
  }
  else {
    return false;
  }
}

Stream<bool> isFavoriteStream(int province, int county) {
  DatabaseReference ref = _favoriteRef(province, county);
  return ref.onValue.map((event) {
    Object? value = event.snapshot.value;
    if(value != null && value is bool) {
      return value;
    }
    else {
      return false;
    }
  });
}

class CountyId {
  int province;
  int county;

  CountyId(this.province, this.county);
}