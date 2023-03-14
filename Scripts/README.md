# Scripting Setup

## Formatting of story files

The way the story files should be set up is as this example shows

```
(10, 10, 20) "This is the comment that I want to be able to read" {
  - User : "Jimby Jones"
  - Pfp : "heheha.jpg"
  - Cmt: "This is one potential response comment " (10, -10)
  - Cmt: "This is one additional potential response comment " (0, 11)
  - Cmt: "This is a third addtional potential response" (-20, 200)
};

(20, -10, 2) "This is an additional comment I want to be able to read" {
  - User : "BRAZIL ES NUMERO UNO"
  - Pfp : "trapgoku.jpg"
  - Cmt: "This is one potential response comment" (11, 0)
  - Cmt: "This is another comment" (11, 1)
  - Cmt: "Another comment" (-20, -15)
};
```

The format is as follows:

1. Title
  - **Example: Comments.txt**
  - The title should be `{Comments, Uploads, Watches}.txt`
  - This way it will be easier to know what elements of the story the entries are associated with

2. Blocks
  - **Example: The following is a single block** 
```
(10, 10, 20) "This is the comment that I want to be able to read" {
  - User : "Jimby Jones"
  - Pfp : "heheha.jpg"
  - Cmt: "This is one potential response comment " (10, -10)
  - Cmt: "This is one additional potential response comment " (0, 11)
  - Cmt: "This is a third addtional potential response" (-20, 200)
};
  ```
  - Each block should be separated by a semicolon
  - In each block, a single potential option to serve the player should be used (a video or comment)

3. Parameters
  - **Example: **`(10, 10, 20)`
  - This represents the minimum values of `good_end, end_a, time_elapsed`
  - **good_end** represents the threshold number of points towards the "good ending" of the game needed for this block to be an option for the player
  - **end_a** represents the threshold number of points towards "ending a" for this block to be an option that can show up
  - **time_elasped** represents the number of days or time intervals that need to have passed for this block to be an option for the player to choose

4. Value
  - **Example: "This is the comment that I want to be able to read"**
  - This is the name of the video or words in the comment to be used

5. Attributes
  - **Example : ** 
  ```
{
  - User : "Jimby Jones"
  - Pfp : "heheha.jpg"
  - Cmt: "This is one potential response comment " (10, -10)
  - Cmt: "This is one additional potential response comment " (0, 11)
  - Cmt: "This is a third addtional potential response" (-20, 200)
}
```

6. Semicolon
  - Try to put a semicolon between each block.
