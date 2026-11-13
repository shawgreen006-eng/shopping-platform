<script setup>
import { ref, onMounted } from 'vue'

const products = ref([])
const keyword = ref('')
const loading = ref(true)
const error = ref('')

function formatPrice(price) {
  return Number(price).toFixed(2)
}

async function loadProducts() {
  loading.value = true
  error.value = ''

  try {
    const query = encodeURIComponent(keyword.value.trim())
    const response = await fetch(`/api/products?keyword=${query}`)

    if (!response.ok) {
      throw new Error('获取商品失败')
    }

    products.value = await response.json()
  } catch {
    error.value = '商品加载失败，请检查 Java 后端和 MySQL 是否正在运行。'
  } finally {
    loading.value = false
  }
}

function clearSearch() {
  keyword.value = ''
  loadProducts()
}

onMounted(loadProducts)
</script>

<template>
  <main class="page">
    <header class="hero">
      <p class="eyebrow">GOOD TECH · GOOD EVERYDAY</p>
      <h1>发现适合你的数码好物</h1>
      <p class="hero-copy">从日常办公到随身数码，挑选让生活更顺手的装备。</p>

      <form class="search" @submit.prevent="loadProducts">
        <input v-model="keyword" type="search" placeholder="搜索商品名称，例如：鼠标" aria-label="搜索商品" />
        <button class="search-button" type="submit">搜索商品</button>
        <button v-if="keyword" class="clear-button" type="button" @click="clearSearch">清空</button>
      </form>
    </header>

    <section class="catalog" aria-labelledby="catalog-title">
      <div class="section-heading">
        <div>
          <p class="section-label">SHOP COLLECTION</p>
          <h2 id="catalog-title">精选商品</h2>
        </div>
        <span v-if="!loading && !error" class="product-count">{{ products.length }} 件商品</span>
      </div>

      <p v-if="loading" class="status">正在加载商品……</p>
      <p v-else-if="error" class="status error">{{ error }}</p>
      <p v-else-if="products.length === 0" class="status">没有找到相关商品，换个关键词试试。</p>

      <div v-else class="product-grid">
        <article v-for="product in products" :key="product.id" class="product-card">
          <div class="image-wrap">
            <img v-if="product.imageUrl" :src="product.imageUrl" :alt="product.name" loading="lazy" />
            <span v-else class="image-placeholder">暂无图片</span>
          </div>
          <div class="card-body">
            <span class="category">{{ product.category || '数码商品' }}</span>
            <h3>{{ product.name }}</h3>
            <p class="description">{{ product.description || '精选数码好物。' }}</p>
            <div class="card-footer">
              <p class="price"><span>¥</span>{{ formatPrice(product.price) }}</p>
              <span class="stock">库存 {{ product.stock }} 件</span>
            </div>
          </div>
        </article>
      </div>
    </section>
  </main>
</template>

<style>
* { box-sizing: border-box; }
body { margin: 0; color: #22302c; background: #f6f7f3; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'PingFang SC', 'Microsoft YaHei', sans-serif; }
button, input { font: inherit; }
.page { min-height: 100vh; }
.hero { padding: 76px max(24px, calc((100vw - 1180px) / 2)) 72px; background: linear-gradient(120deg, #e9f2eb, #f7f8f3 62%, #efece5); }
.eyebrow, .section-label { margin: 0 0 15px; color: #477962; font-size: 12px; font-weight: 800; letter-spacing: 0.16em; }
h1 { max-width: 800px; margin: 0; font-size: clamp(36px, 5vw, 62px); line-height: 1.15; letter-spacing: -0.05em; }
.hero-copy { margin: 20px 0 30px; color: #64726b; font-size: 17px; }
.search { display: flex; align-items: center; gap: 10px; max-width: 650px; }
.search input { flex: 1; min-width: 0; height: 52px; padding: 0 18px; border: 1px solid #d1ddd3; border-radius: 12px; outline: none; background: #fff; }
.search input:focus { border-color: #477962; box-shadow: 0 0 0 3px #47796222; }
.search button { height: 52px; padding: 0 22px; border: 0; border-radius: 12px; cursor: pointer; font-weight: 700; }
.search-button { color: #fff; background: #2d654b; }
.search-button:hover { background: #23523d; }
.clear-button { color: #355b47; background: #e5ebe4; }
.catalog { max-width: 1228px; margin: 0 auto; padding: 56px 24px 90px; }
.section-heading { display: flex; justify-content: space-between; align-items: end; margin-bottom: 26px; }
.section-heading h2 { margin: 0; font-size: 32px; letter-spacing: -0.04em; }
.product-count { color: #748078; font-size: 14px; }
.status { padding: 32px; border-radius: 14px; background: #fff; color: #627169; }
.error { color: #a13c3c; }
.product-grid { display: grid; grid-template-columns: repeat(3, minmax(0, 1fr)); gap: 24px; }
.product-card { overflow: hidden; border: 1px solid #e8ece6; border-radius: 18px; background: #fff; box-shadow: 0 12px 32px #2d4b3910; }
.image-wrap { display: flex; align-items: center; justify-content: center; aspect-ratio: 1.18; overflow: hidden; background: #f4f2ed; }
.image-wrap img { display: block; width: 100%; height: 100%; object-fit: cover; }
.image-placeholder { color: #87958d; }
.card-body { padding: 23px 24px 25px; }
.category { display: inline-block; color: #477962; font-size: 12px; font-weight: 700; }
.card-body h3 { margin: 9px 0 8px; font-size: 22px; }
.description { min-height: 42px; margin: 0; color: #758077; font-size: 14px; line-height: 1.6; }
.card-footer { display: flex; align-items: baseline; justify-content: space-between; gap: 10px; margin-top: 18px; }
.price { margin: 0; color: #224e38; font-size: 25px; font-weight: 800; }
.price span { margin-right: 2px; font-size: 16px; }
.stock { color: #8b968e; font-size: 13px; white-space: nowrap; }
@media (max-width: 850px) { .product-grid { grid-template-columns: repeat(2, minmax(0, 1fr)); } }
@media (max-width: 580px) { .hero { padding: 55px 20px; } .search { flex-wrap: wrap; } .search input { flex-basis: 100%; } .search button { flex: 1; } .catalog { padding: 42px 20px 70px; } .product-grid { grid-template-columns: 1fr; } }
</style>
