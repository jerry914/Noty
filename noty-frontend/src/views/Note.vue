<template>
  <Collections></Collections>
  <Chat @new-card="addCard" />
  <div class="card-view-container">
    <Cards :cards="cards" @archive-card="archiveCard" @update-card="updateCard" />
  </div>
</template>

<script>
import Chat from '../components/Chat.vue';
import Cards from '../components/Cards.vue';
import Collections from '../components/CollectionList.vue'

export default {
  components: {
    Chat,
    Cards,
    Collections
  },
  data() {
    return {
      cards: [
        {
            title: "This is an example",
            content: `
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
  mounted() {
    this.fetchCards();
  },
  watch: {
    '$route.params.id': function(id) {
      this.fetchCards();
    }
  },
  methods: {
    async fetchCards() {
      try {
        let noteUrl = '/api/notes/unarchived'
        if (this.$route.params.id) {
          noteUrl = '/api/collections/'+this.$route.params.id+'/notes'
        }
        const response = await fetch(noteUrl);
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        const data = await response.json();
        this.cards = data;
      } catch (error) {
        console.error('Error fetching cards:', error);
      }
    },
    async addCard(card) {
      try {
        const response = await fetch('/api/notes', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify(card)
        });
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        const newCard = await response.json();
        this.cards.push(newCard.note);
      } catch (error) {
        console.error('Error adding card:', error);
      }
    },
    async archiveCard(index) {
      try {
        const card = this.cards[index];
        const response = await fetch(`/api/notes/${card.id}`, {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({ status: 'archieved' })
        });
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        const updatedCard = await response.json();
        this.cards[index].content = updatedCard.note.content;
      } catch (error) {
        console.error('Error updating card:', error);
      }
    },
    async deleteCard(index) {
      try {
        const card = this.cards[index];
        const response = await fetch(`/api/notes/${card.id}`, {
          method: 'DELETE'
        });
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        this.cards.splice(index, 1);
      } catch (error) {
        console.error('Error archiving card:', error);
      }
    },
    async updateCard(index, updatedContent) {
      try {
        const card = this.cards[index];
        const response = await fetch(`/api/notes/${card.id}`, {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({ content: updatedContent })
        });
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        const updatedCard = await response.json();
        this.cards[index].content = updatedCard.note.content;
      } catch (error) {
        console.error('Error updating card:', error);
      }
    }
  }
}
</script>

<style scoped>
.card-view-container {
    margin: auto;
    columns: 4 300px;
    column-gap: 1rem;
}
</style>
