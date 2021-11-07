var movie_model = [
  const MovieModel(
      "Iron Man",
      "Lorem ipsum dolor sit amet, consectetur.",
      "4.0",
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
      "assets/posters/poster1.jpg"),
  const MovieModel(
      "Iron Man 2",
      "Sed ut perspiciatis unde omnis iste natus.",
      "4.5",
      "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam.",
      "assets/posters/poster3.jpg"),
  const MovieModel(
      "Iron Man 3",
      "At vero eos et accusamus et iusto.",
      "4.2",
      "At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti.",
      "assets/posters/poster5.jpg"),
  const MovieModel(
      "Iron Man 4",
      "Dolore magnam aliquam quaerat voluptatem.",
      "4.7",
      "Dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis.",
      "assets/posters/poster2.jpg"),
  const MovieModel(
      "Iron Man 5",
      "minim veniam, quis nostrud exercitation ullamco.",
      "4.4",
      "minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in.",
      "assets/posters/poster4.jpg")
];

class MovieModel {
  final String title;
  final String description;
  final String story;
  final String poster;
  final String rating;

  const MovieModel(
      this.title, this.description, this.rating, this.story, this.poster);
}
