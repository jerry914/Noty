<template>
  <div class="card-view-container">
    <Chat @new-card="addCard" />
    <Cards :cards="cards" @archive-card="archiveCard" @update-card="updateCard" />
  </div>
</template>

<script>
import Chat from '../components/Chat.vue';
import Cards from '../components/Cards.vue';

export default {
  components: {
    Chat,
    Cards
  },
  data() {
    return {
      cards: [
        {
            question: "This is an example",
            answer: `
            <p>
            Markdown shortcuts make it easy to format the text while typing.
            </p>
            <p>
            To test that, start a new line and type <code>#</code> followed by a space to get a heading. Try <code>#</code>, <code>##</code>, <code>###</code>, <code>####</code>, <code>#####</code>, <code>######</code> for different levels.
            </p>
            <p>
            Those conventions are called input rules in Tiptap. Some of them are enabled by default. Try <code>></code> for blockquotes, <code>*</code>, <code>-</code> or <code>+</code> for bullet lists, or <code>\`foobar\`</code> to highlight code, <code>~~tildes~~</code> to strike text, or <code>==equal signs==</code> to highlight text.
            </p>
            <p>
            We added the <code>Typography</code> extension here. Try typing <code>(c)</code> to see how it’s converted to a proper © character. You can also try <code>-></code>, <code>>></code>, <code>1/2</code>, <code>!=</code>, or <code>--</code>.
            </p>
            <p>
                    That’s a boring paragraph followed by a fenced code block:
                    </p>
                    <pre><code>for (var i=1; i <= 20; i++)
{
if (i % 15 == 0)
    console.log("FizzBuzz");
else if (i % 3 == 0)
    console.log("Fizz");
else if (i % 5 == 0)
    console.log("Buzz");
else
    console.log(i);
}</code></pre>
<h3> How to use AI in a card?</h3>

<p>Example: Add <code>Summarize this</code> at the end of the card, and then click, submit, you will get the following response:

<blockquote><p>Markdown shortcuts simplify text formatting.... The example ends with a "FizzBuzz" JavaScript code block.</p></blockquote>
                    <p>`
        }
      ]
    };
  },
  methods: {
    addCard(card) {
      this.cards.push(card);
    },
    archiveCard(index) {
      this.cards.splice(index, 1);
    },
    updateCard(index, updatedAnswer) {
      this.cards[index].answer = updatedAnswer
    },
  }
}
</script>

<style scoped>
.card-view-container {
    max-width: 80vw;
    margin: auto;
    columns: 4 300px;
    column-gap: 1rem;
}
</style>
