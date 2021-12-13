import 'package:flutter/material.dart';

import 'package:movieapp/models/movie.dart';

class MovieApp extends StatelessWidget {
  final List<Movie> _movielist = Movie.getMovies();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Movies",
          ),
          toolbarHeight: 60,
          backgroundColor: Colors.blueGrey.shade900,
        ),
        backgroundColor: Colors.blueGrey.shade900,
        body: Padding(
          padding: const EdgeInsets.only(top: 28.0),
          child: ListView.builder(
              itemCount: _movielist.length,
              itemBuilder: (BuildContext context, int index) {
                return Stack(children: [
                  movieCard(context, _movielist[index]),
                  Positioned(
                      top: 10,
                      left: 5,
                      child: movieImage(context, _movielist[index].poster)),
                ]);
              }),
        ),
      ),
    );
  }

  Widget movieCard(BuildContext context, Movie movie) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
        margin: EdgeInsets.only(left: 50),
        height: 120,
        width: MediaQuery.of(context).size.width,
        child: Card(
          color: Colors.black45,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 54),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "${movie.title}",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Directed By: ${movie.director}",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w200,
                          fontSize: 12),
                    ),
                    Text(
                      "Release Year: ${movie.year}",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w200,
                          fontSize: 12),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Genre: ${movie.genre}",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w200,
                          fontSize: 12),
                    ),
                    Text(
                      "Rating: ${movie.rated}/5.0",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w200,
                          fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieDetails(movie: movie)));
      },
    );
  }

  Widget movieImage(BuildContext context, String image) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class MovieDetails extends StatelessWidget {
  final Movie movie;

  MovieDetails({this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        title: Text(movie.title),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: ListView(
        children: [
          MovieThumbnail(image: movie.images),
          Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: MoviePosterDetails(
              movie: movie,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 32.0),
            child: HorizontalLine(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: MovieDetailsCast(
              movie: movie,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 32.0),
            child: HorizontalLine(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 32),
            child: CastImages(images: movie.castImages),
          ),
        ],
      ),
    );
  }
}

class MovieThumbnail extends StatelessWidget {
  final String image;

  MovieThumbnail({this.image});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 360,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.cover),
              ),
            ),
            Icon(
              Icons.play_circle_outline,
              size: 100,
              color: Colors.white,
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0x00f5f5f5), Colors.blueGrey.shade900],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          height: 160,
        )
      ],
    );
  }
}

class MoviePosterDetails extends StatelessWidget {
  final Movie movie;

  MoviePosterDetails({this.movie});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          MoviePoster(poster: movie.poster),
          SizedBox(
            width: 20,
          ),
          Expanded(
              child: MovieDetailsDetails(
            movie: movie,
          ))
        ],
      ),
    );
  }
}

class MoviePoster extends StatelessWidget {
  final String poster;

  MoviePoster({this.poster});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: 250,
          decoration: BoxDecoration(
            image:
                DecorationImage(image: NetworkImage(poster), fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}

class MovieDetailsDetails extends StatelessWidget {
  final Movie movie;

  MovieDetailsDetails({this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${movie.year} | ${movie.genre}",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w200),
        ),
        Text("${movie.title}",
            style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w400)),
        SizedBox(
          height: 10,
        ),
        Text.rich(TextSpan(
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w200),
            children: [TextSpan(text: movie.plot)]))
      ],
    );
  }
}

class MovieDetailsCast extends StatelessWidget {
  final Movie movie;

  MovieDetailsCast({this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          MovieField(
            value: movie.actors,
            field: "Cast      ",
          ),
          MovieField(
            value: movie.director,
            field: "Director",
          ),
          MovieField(
            value: movie.awards,
            field: "Awards ",
          ),
        ],
      ),
    );
  }
}

class MovieField extends StatelessWidget {
  final String value;
  final String field;

  MovieField({this.field, this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$field : ",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w200,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HorizontalLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.5,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
    );
  }
}

class CastImages extends StatelessWidget {
  final List images;

  CastImages({this.images});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Cast Images: ",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w300, fontSize: 18),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              height: 240,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => SizedBox(
                  width: 8,
                  child: Text("HEY"),
                ),
                itemCount: images.length,
                itemBuilder: (context, index) => ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 4.5,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: NetworkImage(images[index]),
                      fit: BoxFit.cover,
                    )),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
