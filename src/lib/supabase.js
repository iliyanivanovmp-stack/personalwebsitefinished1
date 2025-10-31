import { createClient } from '@supabase/supabase-js'

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY

if (!supabaseUrl || !supabaseAnonKey) {
  throw new Error('Missing Supabase environment variables. Please check your .env file.')
}

export const supabase = createClient(supabaseUrl, supabaseAnonKey)

// Contact form submission function
export async function submitContactForm(formData) {
  try {
    const { data, error } = await supabase
      .from('contact_submissions')
      .insert([
        {
          name: formData.name,
          email: formData.email,
          service: formData.service,
          company: formData.company || null,
          topic: formData.topic,
          additional: formData.additional || null
        }
      ])
      .select()

    if (error) {
      console.error('Supabase error:', error)
      throw error
    }

    return { success: true, data }
  } catch (error) {
    console.error('Error submitting contact form:', error)
    return { 
      success: false, 
      error: error.message || 'An unexpected error occurred' 
    }
  }
}

// Function to get all contact submissions (for admin use)
export async function getContactSubmissions() {
  try {
    const { data, error } = await supabase
      .from('contact_submissions')
      .select('*')
      .order('created_at', { ascending: false })

    if (error) {
      throw error
    }

    return { success: true, data }
  } catch (error) {
    console.error('Error fetching contact submissions:', error)
    return { 
      success: false, 
      error: error.message || 'An unexpected error occurred' 
    }
  }
}