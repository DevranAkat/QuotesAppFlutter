class Quote {
  final int id;
  final String text;
  final String author;
  final String category;
  bool liked;

  Quote({required this.id, required this.text, required this.author, required this.category, this.liked = false});
}

List<Quote> quotes = [
  Quote(id: 0, text: "Your time is limited, don't waste it.", author: "Steve Jobs", category: "Time"),
  Quote(id: 1, text: "Believe you can and you're halfway there.", author: "Theodore Roosevelt", category: "Belief"),
  Quote(id: 2, text: "Success is not final, failure is not fatal: It is the courage to continue that counts.", author: "Winston Churchill", category: "Success"),
  Quote(id: 3, text: "The only way to do great work is to love what you do.", author: "Steve Jobs", category: "Passion"),
  Quote(id: 4, text: "Don't watch the clock; do what it does. Keep going.", author: "Sam Levenson", category: "Persistence"),
  Quote(id: 5, text: "The future belongs to those who believe in the beauty of their dreams.", author: "Eleanor Roosevelt", category: "Dreams"),
  Quote(id: 6, text: "In the middle of every difficulty lies opportunity.", author: "Albert Einstein", category: "Opportunity"),
  Quote(id: 7, text: "Success is walking from failure to failure with no loss of enthusiasm.", author: "Winston Churchill", category: "Success"),
  Quote(id: 8, text: "The harder you work for something, the greater you'll feel when you achieve it.", author: "Unknown", category: "Hard Work"),
  Quote(id: 9, text: "You miss 100% of the shots you don't take.", author: "Wayne Gretzky", category: "Opportunity"),
  Quote(id: 10, text: "The only limit to our realization of tomorrow will be our doubts of today.", author: "Franklin D. Roosevelt", category: "Doubt"),
  Quote(id: 11, text: "Success is not the key to happiness. Happiness is the key to success. If you love what you are doing, you will be successful.", author: "Albert Schweitzer", category: "Happiness"),
  Quote(id: 12, text: "The road to success and the road to failure are almost exactly the same.", author: "Colin R. Davis", category: "Success"),
  Quote(id: 13, text: "You are never too old to set another goal or to dream a new dream.", author: "C.S. Lewis", category: "Dreams"),
  Quote(id: 14, text: "Believe in yourself and all that you are. Know that there is something inside you that is greater than any obstacle.", author: "Christian D. Larson", category: "Belief"),
  Quote(id: 15, text: "The secret of getting ahead is getting started.", author: "Mark Twain", category: "Starting"),
  Quote(id: 16, text: "Don't count the days, make the days count.", author: "Muhammad Ali", category: "Time"),
  Quote(id: 17, text: "The only person you are destined to become is the person you decide to be.", author: "Ralph Waldo Emerson", category: "Destiny"),
  Quote(id: 18, text: "Dream big and dare to fail.", author: "Norman Vaughan", category: "Dreams"),
  Quote(id: 19, text: "Success usually comes to those who are too busy to be looking for it.", author: "Henry David Thoreau", category: "Success"),
];

List<Quote> randomQuotes = List.from(quotes)..shuffle();