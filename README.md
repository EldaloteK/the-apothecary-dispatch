# the-apothecary-dispatch
A pharmaceutical delivery planner for the hospital environment. Based upon Dijkstra's algorithm and utilizes Docker, Flutter, Dart, Python and Flask.

## Server
```
docker build -f Dockerfile -t tadapi .
docker run -ti --mount type=bind,source="$PWD",target=/app -p 5555:5555 tadapi
python3 -m flask run --host=0.0.0.0 --port=5555
```

## Client
```
flutter clean
flutter pub get
flutter run
```