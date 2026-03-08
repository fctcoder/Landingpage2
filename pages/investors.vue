<template>
  <div>
    <section class="relative py-24 bg-gradient-to-br from-secondary-900 via-secondary-800 to-primary-900 overflow-hidden">
      <div class="absolute inset-0 bg-[url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNjAiIGhlaWdodD0iNjAiIHZpZXdCb3g9IjAgMCA2MCA2MCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48ZyBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPjxnIGZpbGw9IiNmZmYiIGZpbGwtb3BhY2l0eT0iMC4wMyI+PGNpcmNsZSBjeD0iMzAiIGN5PSIzMCIgcj0iMiIvPjwvZz48L2c+PC9zdmc+')] opacity-50"></div>
      <div class="container-custom relative z-10">
        <div class="max-w-3xl">
          <span class="inline-block px-4 py-1 bg-primary-500/20 text-primary-300 rounded-full text-sm font-medium mb-4">
            Investor Relations
          </span>
          <h1 class="text-4xl md:text-5xl lg:text-6xl font-bold text-white mb-6">
            Investor <span class="text-primary-400">Relations</span>
          </h1>
          <p class="text-xl text-secondary-300">
            Access financial reports, corporate governance information, and investor resources.
          </p>
        </div>
      </div>
    </section>

    <section class="section-padding bg-white">
      <div class="container-custom">
        <div class="grid md:grid-cols-2 lg:grid-cols-4 gap-8 mb-16">
          <div class="bg-primary-50 rounded-xl p-6 text-center">
            <p class="text-3xl font-bold text-primary-600">RM 150M</p>
            <p class="text-secondary-600 mt-2">Annual Revenue</p>
          </div>
          <div class="bg-primary-50 rounded-xl p-6 text-center">
            <p class="text-3xl font-bold text-primary-600">25%</p>
            <p class="text-secondary-600 mt-2">YoY Growth</p>
          </div>
          <div class="bg-primary-50 rounded-xl p-6 text-center">
            <p class="text-3xl font-bold text-primary-600">25+</p>
            <p class="text-secondary-600 mt-2">Countries</p>
          </div>
          <div class="bg-primary-50 rounded-xl p-6 text-center">
            <p class="text-3xl font-bold text-primary-600">100+</p>
            <p class="text-secondary-600 mt-2">Employees</p>
          </div>
        </div>
      </div>
    </section>

    <section class="section-padding bg-secondary-50">
      <div class="container-custom">
        <div class="text-center mb-12">
          <h2 class="section-title">Financial Reports</h2>
          <p class="section-subtitle">Access our latest financial statements and reports.</p>
        </div>
        
        <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
          <div 
            v-for="report in reports" 
            :key="report.id"
            class="bg-white rounded-xl shadow-lg p-6 hover:shadow-xl transition-shadow"
          >
            <div class="flex items-start justify-between mb-4">
              <div class="w-12 h-12 bg-primary-100 rounded-lg flex items-center justify-center">
                <svg class="w-6 h-6 text-primary-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                </svg>
              </div>
              <span class="px-2 py-1 bg-primary-100 text-primary-700 text-xs font-medium rounded">
                {{ report.type }}
              </span>
            </div>
            <h3 class="text-lg font-semibold text-secondary-900 mb-2">{{ report.title }}</h3>
            <p class="text-secondary-600 text-sm mb-4">{{ report.year }} {{ report.quarter }}</p>
            <button class="flex items-center text-primary-600 hover:text-primary-700 font-medium text-sm">
              <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4" />
              </svg>
              Download PDF
            </button>
          </div>
        </div>
      </div>
    </section>

    <section class="section-padding bg-white">
      <div class="container-custom">
        <div class="text-center mb-12">
          <h2 class="section-title">Board of Directors</h2>
          <p class="section-subtitle">Meet our experienced leadership team.</p>
        </div>
        
        <div class="grid md:grid-cols-2 lg:grid-cols-4 gap-8">
          <div 
            v-for="member in boardMembers" 
            :key="member.id"
            class="text-center"
          >
            <div class="w-32 h-32 bg-secondary-200 rounded-full mx-auto mb-4 flex items-center justify-center">
              <span class="text-3xl font-bold text-secondary-400">{{ member.name.charAt(0) }}</span>
            </div>
            <h3 class="text-lg font-semibold text-secondary-900">{{ member.name }}</h3>
            <p class="text-primary-600 text-sm">{{ member.position }}</p>
            <p class="text-secondary-600 text-sm mt-2">{{ member.bio }}</p>
          </div>
        </div>
      </div>
    </section>

    <section class="section-padding bg-secondary-50">
      <div class="container-custom">
        <div class="text-center mb-12">
          <h2 class="section-title">Corporate Governance</h2>
          <p class="section-subtitle">Our commitment to transparency and ethical business practices.</p>
        </div>
        
        <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
          <div 
            v-for="doc in governanceDocs" 
            :key="doc.id"
            class="bg-white rounded-xl shadow-lg p-6 flex items-center gap-4 hover:shadow-xl transition-shadow"
          >
            <div class="w-12 h-12 bg-secondary-100 rounded-lg flex items-center justify-center flex-shrink-0">
              <svg class="w-6 h-6 text-secondary-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
              </svg>
            </div>
            <div>
              <h3 class="font-semibold text-secondary-900">{{ doc.title }}</h3>
              <button class="text-primary-600 text-sm hover:underline">View Document</button>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section class="section-padding bg-primary-600">
      <div class="container-custom">
        <div class="max-w-3xl mx-auto text-center">
          <h2 class="text-3xl font-bold text-white mb-6">Investor Relations Contact</h2>
          <p class="text-primary-100 mb-8">
            For investor inquiries, please contact our Investor Relations team.
          </p>
          <div class="bg-white/10 backdrop-blur-sm rounded-xl p-8 text-left">
            <div class="grid md:grid-cols-2 gap-6">
              <div>
                <h4 class="text-white font-semibold mb-2">Investor Relations</h4>
                <p class="text-primary-100">Mr. David Tan</p>
                <p class="text-primary-200 text-sm">Head of Investor Relations</p>
              </div>
              <div>
                <h4 class="text-white font-semibold mb-2">Contact</h4>
                <p class="text-primary-100">ir@spadex.com</p>
                <p class="text-primary-100">+60 3-6156 5888 ext. 101</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup lang="ts">
useHead({
  title: 'Investor Relations - SpadeX',
  meta: [
    { name: 'description', content: 'Access SpadeX financial reports, corporate governance information, and investor resources.' }
  ]
})

const reports = [
  { id: '1', title: 'Annual Report 2023', type: 'Annual', year: 2023, quarter: '' },
  { id: '2', title: 'Q4 2023 Financial Report', type: 'Quarterly', year: 2023, quarter: 'Q4' },
  { id: '3', title: 'Q3 2023 Financial Report', type: 'Quarterly', year: 2023, quarter: 'Q3' },
  { id: '4', title: 'Annual Report 2022', type: 'Annual', year: 2022, quarter: '' },
  { id: '5', title: 'Q2 2023 Financial Report', type: 'Quarterly', year: 2023, quarter: 'Q2' },
  { id: '6', title: 'Q1 2023 Financial Report', type: 'Quarterly', year: 2023, quarter: 'Q1' }
]

const boardMembers = [
  { id: '1', name: 'Datuk Ahmad Razak', position: 'Chairman', bio: '30+ years in manufacturing industry' },
  { id: '2', name: 'Sarah Chen', position: 'CEO', bio: 'Former VP at Siemens' },
  { id: '3', name: 'Michael Thompson', position: 'CFO', bio: 'Ex-KPMG Senior Partner' },
  { id: '4', name: 'Dr. Lisa Wong', position: 'CTO', bio: 'PhD in Automation Engineering' }
]

const governanceDocs = [
  { id: '1', title: 'Board Charter' },
  { id: '2', title: 'Code of Conduct' },
  { id: '3', title: 'Anti-Corruption Policy' },
  { id: '4', title: 'Whistleblower Policy' },
  { id: '5', title: 'Sustainability Report' },
  { id: '6', title: 'Audit Committee Report' }
]
</script>
